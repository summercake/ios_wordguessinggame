//
//  Game.swift
//  WordGuessingGame
//
//  Created by jack on 2/8/18.
//  Copyright © 2018 jack. All rights reserved.
//

import Foundation

struct Game{
    var word : String;
    var remainingIncorrectMoves : Int;
    var guessedLetters:[Character];
    var formattedWord: String{
        var guessedWord = "";
        for letter in word{
            if guessedLetters.contains(letter){
                guessedWord += "\(letter)";
            }else{
                guessedWord += "_"
            }
        }
        print(guessedWord)
        return guessedWord;
    }
    
    mutating func playerGuessed(letter: Character){
        guessedLetters.append(letter);
        if !word.contains(letter){
            remainingIncorrectMoves -= 1;
        }
    }
}
