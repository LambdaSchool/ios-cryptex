//
//  CryptexController.swift
//  Cryptex
//
//  Created by Jonathan Ferrer on 5/8/19.
//  Copyright © 2019 Jonathan Ferrer. All rights reserved.
//

import Foundation

class CryptexController {

    init() {
        randomCryptex()
    }
    var cryptexes: [Cryptex] = [Cryptex(password: "JON", hint: "What is my name?"), Cryptex(password: "IOS", hint: "What os are you coding for?"),Cryptex(password: "NYC", hint: "What city am I in?"), Cryptex(password: "IPHONE", hint: "What device is this running on?")]

    var currentCryptex: Cryptex?

    func randomCryptex(){
        currentCryptex = cryptexes.randomElement()

    }


}
