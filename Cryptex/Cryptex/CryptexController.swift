//
//  CryptexController.swift
//  Cryptex
//
//  Created by Jonathan Ferrer on 5/1/19.
//  Copyright © 2019 Jonathan Ferrer. All rights reserved.
//

import Foundation



class CryptexController {
    
    init() {
        randomCryptex()
    }
    
    private var cryptextes: [Cryptex] = [Cryptex(password: "JON", hint: "My name!"), Cryptex(password: "SWIFT", hint:"The language you are coding in!"), Cryptex(password: "LAMBDA", hint: "Your school!")]
    
    var currentCryptex: Cryptex?
    
    func randomCryptex() {
        let randomCryptex = cryptextes.randomElement()
        currentCryptex = randomCryptex
    }
   
    
}
