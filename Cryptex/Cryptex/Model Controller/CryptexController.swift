//
//  CryptexController.swift
//  Cryptex
//
//  Created by Lisa Sampson on 5/1/19.
//  Copyright © 2019 Lisa M Sampson. All rights reserved.
//

import Foundation

class CryptexController {
    
    // MARK: - Properties
    
    private var cryptexes: [Cryptex] = [Cryptex(password: "FOO", hint: "A common placeholder word in programming"), Cryptex(password: "CRYPTEX", hint: "The thing you are trying to solve right now"), Cryptex(password: "METHOD", hint: "What a function is called inside of a class or struct"), Cryptex(password: "COREDATA", hint: "An advanced way of persisting data")]
    
    var currentCryptex: Cryptex?
    
    
    // MARK: - Initializers and Methods
    
    init() {
        randomCryptex()
    }
    
    func randomCryptex() {
        currentCryptex = cryptexes.randomElement()
    }
}
