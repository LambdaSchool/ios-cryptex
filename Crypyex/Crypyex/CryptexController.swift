//
//  CryptexController.swift
//  Crypyex
//
//  Created by Hayden Hastings on 5/8/19.
//  Copyright © 2019 Hayden Hastings. All rights reserved.
//

import Foundation

class CryptexController {
    
    init() {
        randomCryptex()
    }
    
    func randomCryptex() {
        
        currentCryptex = cryptexes.randomElement()
    }
    
    private var cryptexes: [Cryptex] = [Cryptex(password: "CRYPTEX", hint: "What is a cryptex?"), Cryptex(password: "PASSWORD", hint: "A likely password"), Cryptex(password: "LASVEGAS", hint: "Sin City")]
    
    var currentCryptex: Cryptex?
}
