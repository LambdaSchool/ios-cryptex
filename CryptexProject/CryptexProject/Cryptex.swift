//
//  Cryptex.swift
//  CryptexProject
//
//  Created by Thomas Cacciatore on 5/1/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

import Foundation

struct Cryptex {
    var password: String
    var hint: String
    
    init(password: String, hint: String) {
        self.password = password
        self.hint = hint
    }
}
