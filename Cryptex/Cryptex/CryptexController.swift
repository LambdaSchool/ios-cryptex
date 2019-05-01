//
//  CryptexController.swift
//  Cryptex
//
//  Created by morse on 5/1/19.
//  Copyright © 2019 morse. All rights reserved.
//

import Foundation

class CryptexController {
    private var cryptexes: [Cryptex] = []
    var currentCryptex: Cryptex?
    
    init() {
        
        cryptexes.append(Cryptex(password: "timer", hint: "A  device that counts down"))
        cryptexes.append(Cryptex(password: "foo", hint: "A common placeholder"))
        cryptexes.append(Cryptex(password: "cryptex", hint: "The game you're playing now"))
        
        randomCryptex()
    }
    
    func randomCryptex() {
        currentCryptex = cryptexes.randomElement()
    }
    
    
    
}
