//
//  Cryptex.swift
//  Cryptex
//
//  Created by Ryan Murphy on 5/1/19.
//  Copyright © 2019 Ryan Murphy. All rights reserved.
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
