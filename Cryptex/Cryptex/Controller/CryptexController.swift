//
//  CryptexController.swift
//  Cryptex
//
//  Created by Seschwan on 5/14/19.
//  Copyright © 2019 Seschwan. All rights reserved.
//

import Foundation

class CryptexController {
    
    init() {
        randomCryptex()
    }
    
    var cryptexArray: [Cryptex] = [Cryptex(password: "DOOR", hint: "don't slam it.."),
                                   Cryptex(password: "BIKE", hint: "has two wheels.."),
                                   Cryptex(password: "FOX", hint: "what does it say?")]
    
    var currentCryptex: Cryptex?
    
    func randomCryptex() {
        let random = cryptexArray.randomElement()
        currentCryptex = random
    }
}
