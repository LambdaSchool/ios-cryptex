//
//  CryptexController.swift
//  Cryptex
//
//  Created by Ryan Murphy on 5/1/19.
//  Copyright © 2019 Ryan Murphy. All rights reserved.
//

import Foundation



class CryptexController {
    
    init() {
        randomCryptex()
    }
    
    private var cryptextes: [Cryptex] = [Cryptex(password: "cat", hint: "Animal that Meows."), Cryptex(password: "ryan", hint:"What is my name?"), Cryptex(password: "cryptex", hint: "What are you trying to solve right now?")]
    
    var currentCryptex: Cryptex?
    
    func randomCryptex() {
        let randomCryptex = cryptextes.randomElement()
        currentCryptex = randomCryptex
    }
    
    
}

    
  
    
    




