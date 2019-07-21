//
//  CryptexController.swift
//  Cryptex
//
//  Created by Nathan Hedgeman on 5/14/19.
//  Copyright © 2019 Nate Hedgeman. All rights reserved.
//

import Foundation

class CryptexController {
    
    init() {
        
        create(password: "NATHAN", hint: "My Name")
        create(password: "LAMBDA", hint: "My School")
        create(password: "MEW", hint: "The Best Pokemon")
        
        randomCryptex()
    }
    
    private (set) var cryptexes: [Cryptex] = []
    
    func create (password: String, hint: String) {
        
        let crypt = Cryptex(password: password, hint: hint)
        
        cryptexes.append(crypt)
        
    }
    // MARK: Random Cryptex selector
    var currentCryptex: Cryptex?
    
    func randomCryptex() {
        let randomCryptex = cryptexes.randomElement()
        
        currentCryptex = randomCryptex
    }

    
}
