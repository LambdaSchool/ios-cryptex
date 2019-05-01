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
        cryptexes.append(Cryptex(password: "CRYPTEX", hint: "The name of this application"))
        cryptexes.append(Cryptex(password: "SWIFT", hint: "The best programming language ever"))
        
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
