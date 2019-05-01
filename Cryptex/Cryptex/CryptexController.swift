//
//  CryptexController.swift
//  Cryptex
//
//  Created by Christopher Aronson on 5/1/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

import Foundation

class CryptexController {
    private let cryptex: [Cryptex] = [Cryptex(password: "Hello", hint: "A greeting"),
                              Cryptex(password: "Pizza", hint: "Italian triangles"),
                              Cryptex(password: "var", hint: "Not a let")]
    var currentCryptex: Cryptex?
    
    init() {
        currentCryptex = randomCryptex()
    }
    
    func randomCryptex() -> Cryptex {
        return cryptex.randomElement() ?? Cryptex(password: "idiot", hint: "What I am if you see this")
    }
    
}
