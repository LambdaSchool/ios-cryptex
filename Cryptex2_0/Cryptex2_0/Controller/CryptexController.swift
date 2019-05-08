//
//  CryptexController.swift
//  Cryptex2_0
//
//  Created by Kobe McKee on 5/8/19.
//  Copyright © 2019 Kobe McKee. All rights reserved.
//

import Foundation

class CryptexController {
    
    init() {
        randomCryptex()
    }
    
    private var cryptexes: [Cryptex] = [Cryptex(password: "portland", hint: "RIP City"),
                                Cryptex(password: "password", hint: "Password"),
                                Cryptex(password: "kobe", hint: "What's my name?"),
                                Cryptex(password: "borderlands", hint: "Greatness coming soon")]
    
    
    var currentCryptex: Cryptex?
    
    func randomCryptex() {
        currentCryptex = cryptexes.randomElement()
    }
    
}
