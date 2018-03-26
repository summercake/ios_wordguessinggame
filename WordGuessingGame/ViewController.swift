//
//  ViewController.swift
//  WordGuessingGame
//
//  Created by jack on 2/8/18.
//  Copyright © 2018 jack. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var wordList = ["swift","csharp","ruby","python"];
    let incorrectMovesAllowed = 7;
//    var totalWins = 0{
//        didSet{
//            newRound();
//        }
//    };
//    var totalLosses = 0{
//        didSet{
//            newRound();
//        }
//    };

    var currentGame:Game!
    var playerRound:Player!
    
    
    @IBOutlet weak var imageViewTree: UIImageView!
    
    @IBOutlet weak var labelCorrectWord: UILabel!
    
    @IBOutlet weak var labelScore: UILabel!
    
    
    @IBOutlet var buttonLetters: [UIButton]!
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.isEnabled=false;
        let letterString = sender.title(for:.normal)!;
        let letterGuessed = Character(letterString.lowercased());
//        print(letterGuessed)
        currentGame.playerGuessed(letter: letterGuessed);
        //updateUI();
        updateGameState(player: playerRound.player);
    }
    
    func newRound(){
        if playerRound.player < 3 {
            if !wordList.isEmpty {
                showAlert(msg: "Game Start!!!", display: "player \(playerRound.player)")
                let newWord = wordList.removeFirst();
                currentGame = Game(word:newWord, remainingIncorrectMoves:incorrectMovesAllowed, guessedLetters:[]);
                enableLetterButtons(true);
                updateUI()
            }else{
                showAlert(msg: "Game Start!!!", display: "player \(playerRound.player)")
                labelCorrectWord.text = "";
                labelScore.text = "";
                imageViewTree.image = UIImage(named: "Tree 0");
                enableLetterButtons(true);
                updateUI()
            }
            
        }
    }
    
    func enableLetterButtons(_ enabled: Bool){
        for button in buttonLetters{
            button.isEnabled = enabled;
        }
    }
    
    func updateUI(){
        if playerRound.player == 1  {
            labelScore.text = "Player \(playerRound.player)";
        }else {
            labelScore.text = "Player \(playerRound.player)";
        }
        imageViewTree.image = UIImage(named: "Tree \(currentGame.remainingIncorrectMoves)");
        labelCorrectWord.text = currentGame.formattedWord;
    }
    
    func updateScore(){
        if playerRound.playerOneScore > playerRound.playerTwoScore  {
            labelCorrectWord.text = currentGame.formattedWord;
            labelScore.text = "Winner : player \(playerRound.playerOneScore)";
            showAlert(msg: "Congratulation!!!", display: "Player 1 Win")
        }else if playerRound.playerOneScore < playerRound.playerTwoScore {
            labelCorrectWord.text = currentGame.formattedWord;
            labelScore.text = "Winner : player \(playerRound.playerTwoScore)"
            showAlert(msg: "Congratulation!!!", display: "Player 2 Win")
        }else{
            labelCorrectWord.text = currentGame.formattedWord;
            labelScore.text = "No Winner. Game Tie";
            showAlert(msg: "Game Tie!!!", display: "No Winner")
        }
    }
    
    func updateGameState(player:Int){
        if currentGame.remainingIncorrectMoves == 0{
            if playerRound.player == 1{
                playerRound.playerOneScore = 0
                playerRound.player += 1;
                newRound()
            }else{
                playerRound.playerTwoScore = 0
                updateScore()
            }
        }else if currentGame.word == currentGame.formattedWord{
            if playerRound.player == 1{
                playerRound.playerOneScore += 1
                playerRound.player += 1;
                newRound()
            }else{
                playerRound.playerTwoScore += 1
                updateScore()
            }
        }else{
            updateUI()
        }
    }
    
    func showAlert(msg: String, display: String){
        let alert = UIAlertController(title: msg, message: display, preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil));
        self.present(alert, animated: true);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerRound = Player(player:1, playerOneScore:0, playerTwoScore:0);
        newRound();
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

