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
    
    private var cryptexes: [Cryptex] = [Cryptex(password: "CRYPTEX", hint: "The thing you are trying to solve"), Cryptex(password: "PASSWORD", hint: "a likely password"), Cryptex(password: "LASVEGAS", hint: "Sin city")]
    
    var currentCryptex: Cryptex?
    
    func randomCryptex() {
        currentCryptex = cryptexes.randomElement()
    }
}
