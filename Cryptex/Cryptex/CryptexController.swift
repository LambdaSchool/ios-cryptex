//
//  CryptexController.swift
//  Cryptex
//
//  Created by Jeffrey Carpenter on 5/1/19.
//  Copyright © 2019 Jeffrey Carpenter. All rights reserved.
//

import Foundation

class CryptexController {
    
    var cryptexes: [Cryptex] = []
    var currentCryptex: Cryptex?
    
    init() {
        
        // Add some test data
        cryptexes.append(Cryptex(password: "Cryptex", hint: "The name of this application"))
        cryptexes.append(Cryptex(password: "Swift", hint: "The coolest programming language ever"))
        cryptexes.append(Cryptex(password: "Green", hint: "Grass is what color?"))
        cryptexes.append(Cryptex(password: "Austen", hint: "First name of Lambda CEO"))
        cryptexes.append(Cryptex(password: "Apple", hint: "Company that makes the iPhone"))
        
        // Grab a random cryptex and assign it to currentCryptex
        randomCryptex()
    }
    
    func randomCryptex() {
        
        let newCryptex = cryptexes.randomElement()
        if newCryptex == currentCryptex {
            randomCryptex()
        } else {
            currentCryptex = newCryptex
        }
    }
    
    func hasMatchingPassword(guess: String) -> Bool {
        
        guard let currentCryptex = currentCryptex else { return false }
        
        return guess.uppercased() == currentCryptex.password.uppercased()
    }
    
    func createCryptex(with password: String, hint: String) {
        cryptexes.append(Cryptex(password: password, hint: hint))
        print("Created a new cryptex with \(password) and \(hint).")
    }
}
