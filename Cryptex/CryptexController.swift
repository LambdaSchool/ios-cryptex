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
    
    init() {randomCryptex()}
    
    private func addCryptex() {
        let cryptexOne = Cryptex.init(password: "hello", hint: "what do you say when you meet your friends")
        let cryptexTwo = Cryptex.init(password: "bye", hint: "what do you say when you are done meeting your firends")
        let cryptexThree = Cryptex.init(password: "no", hint: "what do you say when you dont want it")
        
        cryptexs.append(cryptexOne)
        cryptexs.append(cryptexTwo)
        cryptexs.append(cryptexThree)
    }
    
    func randomCryptex() {
        let randomNumber = Int.random(in: 0...cryptexs.count - 1)
        currentCryptex = cryptexs[randomNumber]
    }
}
