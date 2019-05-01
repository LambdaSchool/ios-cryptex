//
//  CryptexController.swift
//  Cryptex
//
//  Created by Christopher Aronson on 5/1/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

import Foundation

class CryptexController {
    private let cryptex: [Cryptex] = [Cryptex(password: "CRYPTEX", hint: "The name of this game"),
                              Cryptex(password: "PIZZA", hint: "Italian triangles"),
                              Cryptex(password: "VAR", hint: "Not a let"),
                              Cryptex(password: "AIRTABLE", hint: "Tool used for daily standup"),
                              Cryptex(password: "CAT", hint: "Small household feline pet"),
                              Cryptex(password: "IPHONE", hint: "The type of phone we develop for")]
    var currentCryptex: Cryptex?
    
    
    init() {
        currentCryptex = randomCryptex()
    }
    
    func randomCryptex() -> Cryptex {
        return cryptex.randomElement() ?? Cryptex(password: "idiot", hint: "What I am if you see this")
    }
    
}
