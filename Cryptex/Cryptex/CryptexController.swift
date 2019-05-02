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
    
    private var cryptextes: [Cryptex] = [Cryptex(password: "CAT", hint: "Animal that Meows."), Cryptex(password: "RYAN", hint:"What is my name?"), Cryptex(password: "CRYPTEX", hint: "What are you trying to solve right now?")]
    
    var currentCryptex: Cryptex?
    
    func randomCryptex() {
        let randomCryptex = cryptextes.randomElement()
        currentCryptex = randomCryptex
    }
    
    
}

    
  
    
    




