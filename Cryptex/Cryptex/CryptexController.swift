//
//  CryptexController.swift
//  Cryptex
//
//  Created by Mitchell Budge on 5/1/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import Foundation


class CryptexController {
    
    init() {
        randomCryptex()
    }
    
    private var cryptexes: [Cryptex] = [Cryptex(password: "CRYPTEX", hint: "What is a cryptex?"), Cryptex(password: "password", hint: "not my password"), Cryptex(password: "PORTLAND", hint: "RIP Cty")]
    
    var currentCryptex: Cryptex?
    
    func randomCryptex() {
        currentCryptex = cryptexes.randomElement()
        // returns a random element of the collection
    }
    
    
    
}
