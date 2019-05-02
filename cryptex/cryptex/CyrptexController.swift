//
//  CyrptexController.swift
//  cryptex
//
//  Created by Michael Flowers on 5/1/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation

class CryptexController {
    
    init() {
        randomCryptex()
    }
    
    private(set) var cryptexes = [Cryptex(password: "HAM", hint: "This goes inside a sandwich."), Cryptex(password: "Nevada", hint: "This is one of six states in america that doesn't have state income tax."), Cryptex(password: "Heather", hint: "Your favorite person to beat in mario kart.")]
    
    var currentCryptex: Cryptex? //this s the property that the view controller will be able to see (as it is not private), and use for settingup the picker view and running some logic.
    
    func randomCryptex(){
        //grab a random cryptex from the array and set the value of current cryptex
        currentCryptex = cryptexes.randomElement()
    }
}
