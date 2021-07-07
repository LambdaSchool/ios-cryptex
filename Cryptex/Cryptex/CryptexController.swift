//
//  CryptexController.swift
//  Cryptex
//
//  Created by Thomas Cacciatore on 5/8/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

import Foundation

class CryptexController {
    private(set) var cryptexes: [Cryptex] = [Cryptex(password: "LAMBDA", hint: "School for coding"), Cryptex(password: "SWIFT", hint: "Best programming language")]
    
    var currentCryptex: Cryptex?
    
    init() {
        randomCryptex()
    }
    
    func randomCryptex() {
        currentCryptex = cryptexes.randomElement()
    }
}
