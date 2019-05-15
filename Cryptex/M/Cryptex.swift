//
//  Cryptex.swift
//  Cryptex
//
//  Created by Nathan Hedgeman on 5/14/19.
//  Copyright © 2019 Nate Hedgeman. All rights reserved.
//

import Foundation

struct Cryptex {
    var password: String
    var hint:     String
    
    init(password: String, hint : String) {
        
        self.password = password
        self.hint = hint
    }
}
