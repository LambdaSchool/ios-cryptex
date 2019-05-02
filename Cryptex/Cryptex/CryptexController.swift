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
    var previousCryptex: Cryptex?
    
    init() {
        
        cryptexes.append(Cryptex(password: "TIMER", hint: "Ao device that counts down"))
        cryptexes.append(Cryptex(password: "FOO", hint: "A common placeholder"))
        cryptexes.append(Cryptex(password: "CRYPTEX", hint: "The game you're playing now"))
        
        randomCryptex()
    }
    
    func randomCryptex() {
        
        repeat {
            currentCryptex = cryptexes.randomElement()
        } while previousCryptex == currentCryptex
        previousCryptex = currentCryptex
    }
}
