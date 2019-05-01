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
        cryptexes.append(Cryptex(password: "Swift", hint: "The best programming language ever"))
        cryptexes.append(Cryptex(password: "Paul", hint: "First name of your sprint 1 & 2 instructor"))
        cryptexes.append(Cryptex(password: "Nelson", hint: "First name of your PM"))
        cryptexes.append(Cryptex(password: "Austen", hint: "First name of Lambda CEO"))
        cryptexes.append(Cryptex(password: "Apple", hint: "Company that makes the iPhone"))
        
        // Grab a random cryptex and assign it to currentCryptex
        randomCryptex()
    }
    
    func randomCryptex() {
        currentCryptex = cryptexes.randomElement()
    }
    
    func hasMatchingPassword(guess: String) -> Bool {
        
        guard let currentCryptex = currentCryptex else { return false }
        
        return guess.uppercased() == currentCryptex.password.uppercased()
    }
}
