//
//  CryptexController.swift
//  CryptexProject
//
//  Created by Thomas Cacciatore on 5/1/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

import Foundation

class CryptexController {
//    let cryptex1 = Cryptex(password: "Swift", hint: "Best Coding Language")
//    let cryptex2 = Cryptex(password: "Lambda", hint: "Innovative school for coding")
   private(set) var cryptexes: [Cryptex] = []
    
    var currentCryptex: Cryptex?
    
    func randomCryptex() {
//        This method should grab a random Cryptex from the cryptexes array and set the value of currentCryptex to it. As of Swift 4.2, there is a very easy way to do this. If you're unsure of what it is, refer to Array in the documentation.
    }
    
    init() {
        randomCryptex()
    }
}
