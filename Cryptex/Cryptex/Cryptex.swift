//
//  Cryptex.swift
//  Cryptex
//
//  Created by Jonathan Ferrer on 5/1/19.
//  Copyright © 2019 Jonathan Ferrer. All rights reserved.
//

import Foundation

struct Cryptex {
    
    let password: String
    let hint: String
    
    init(password: String, hint: String) {
        self.password = password
        self.hint = hint
    }
    
}
