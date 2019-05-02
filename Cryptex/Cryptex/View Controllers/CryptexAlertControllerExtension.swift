//
//  CryptexAlertControllerExtension.swift
//  Cryptex
//
//  Created by Lisa Sampson on 5/1/19.
//  Copyright © 2019 Lisa M Sampson. All rights reserved.
//

import UIKit

extension CryptexViewController {
    
    func presentCorrectPasswordAlert() {
        
        let alert = UIAlertController(title: "Congratulations!", message: "You have successfully guessed the password! Would you like to play again with a new cryptex?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "New cryptex", style: .default, handler: { action in
            self.newCryptexAndReset()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func presentIncorrectPasswordAlert() {
        
        let alert = UIAlertController(title: "Not quite!", message: "Would you like to keep guessing or try a new cryptex?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "New cryptex", style: .default, handler: { action in
            self.newCryptexAndReset()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func presentNoTimeRemainingAlert() {
        
        let alert = UIAlertController(title: "Out of time!", message: "You have ran out of time! Would you like to reset the timer and keep guessing or try a new cryptex?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Reset", style: .default, handler: { action in
            self.reset()
        }))
        alert.addAction(UIAlertAction(title: "New cryptex", style: .default, handler: { action in
            self.newCryptexAndReset()
        }))
        present(alert, animated: true, completion: nil)
    }
}
