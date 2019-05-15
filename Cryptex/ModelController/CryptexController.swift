//
//  CryptexController.swift
//  Cryptex
//
//  Created by Dongwoo Pae on 5/13/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation

class CryptexController {
    var cryptexs: [Cryptex] = []
    
    var currentCryptex: Cryptex?
    
    init() {
        addCryptex()
        randomCryptex()
    }
    
    private func addCryptex() {
        let cryptexOne = Cryptex.init(password: "Pizza", hint: "what is Dongwoo's favorite food?")
        let cryptexTwo = Cryptex.init(password: "Bellevue", hint: "what is the name of city where Dongwoo lives in?")
        let cryptexThree = Cryptex.init(password: "Pae", hint: "what is Dongwoo's last name?")
        
        cryptexs.append(cryptexOne)
        cryptexs.append(cryptexTwo)
        cryptexs.append(cryptexThree)
    }
    
    func randomCryptex() {
        let endCount = cryptexs.count - 1
        let randomNumber = Int.random(in: 0...endCount)
        currentCryptex = cryptexs[randomNumber]
    }
    
}
