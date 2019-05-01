//
//  CryptexController.swift
//  Cryptex
//
//  Created by Hector Steven on 5/1/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation


class CryptexController {
	
	func randomCryptex(){
		if let randomCryptex = cryptexs.randomElement() {
			currentCryptex = randomCryptex
		}
	}
	
	init() {
		
		cryptexs.append(Cryptex(password: "cryptex", hit: "The thing you are trying to solve right now"))
		cryptexs.append(Cryptex(password: "lambda", hit: "The name of your scool"))
		cryptexs.append(Cryptex(password: "code", hit: "The code is a code"))
		
		randomCryptex()
	}
	
	var currentCryptex: Cryptex?
	private(set) var cryptexs: [Cryptex] = []
}

