//
//  CryptexController.swift
//  Cryptex
//
//  Created by Jeremy Taylor on 5/8/19.
//  Copyright © 2019 Bytes-Random L.L.C. All rights reserved.
//

import Foundation

class CryptexController {
    private(set) var cryptexs: [Cryptex] = []
    var currentCryptex: Cryptex?
    
    func randomCryptex() {
        let randomCryptex = cryptexs.randomElement()
        currentCryptex = randomCryptex
    }
    
    init() {
        let cryptex1 = Cryptex(password: "Spock", hint: "Famous Vulcan")
        let cryptex2 = Cryptex(password: "Constant", hint: "Its value can't be changed once set in code")
        let cryptex3 = Cryptex(password: "Elvis", hint: "One of this singer's hits was Hound Dog")
        
        cryptexs.append(cryptex1)
        cryptexs.append(cryptex2)
        cryptexs.append(cryptex3)
        
        randomCryptex()
    }
}
