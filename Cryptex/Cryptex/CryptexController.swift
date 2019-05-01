//
//  CryptexController.swift
//  Cryptex
//
//  Created by Ryan Murphy on 5/1/19.
//  Copyright © 2019 Ryan Murphy. All rights reserved.
//

import Foundation


class CryptextController {
    init() {
        currentCryptext = randomCryptex()
    }
    
    private var cryptexts: [Cryptex] = [Cryptex(password: "Cryptex", hint: "What you are currently trying to solve."), Cryptex(password: "cat", hint: "An animal that meows.")]
    
    var currentCryptext: Cryptex?
    
    func randomCryptex() -> Cryptex {
        _ = cryptexts.randomElement()!
        
    }
    
  
    
    
}



