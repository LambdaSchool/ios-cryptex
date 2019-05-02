//
//  Cryptex.swift
//  Cryptex
//
//  Created by Hector Steven on 5/1/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation

struct Cryptex: Codable, Equatable {
	var password: String
	var hint: String
	
	init(password: String, hint: String){
		self.password = password
		self.hint = hint
	}
}
