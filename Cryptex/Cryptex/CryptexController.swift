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
		cryptexs.append(Cryptex(password: "cryptex", hint: "The thing you are trying to solve right now"))
		cryptexs.append(Cryptex(password: "lambda", hint: "The name of your school"))
		cryptexs.append(Cryptex(password: "hector", hint: "Who created this file"))
		cryptexs.append(Cryptex(password: "alert", hint: "If you win or run out of time you will get an"))
		cryptexs.append(Cryptex(password: "code", hint: "The code is a code"))
		cryptexs.append(Cryptex(password: "endGame", hint: "What Avenger Movie is out Right now"))
		cryptexs.append(Cryptex(password: "zyxwv", hint: "The last 5 letters"))
		cryptexs.append(Cryptex(password: "h", hint: "I wonder. .."))
		randomCryptex()
	}
	
	
	
	var currentCryptex: Cryptex?
	private(set) var cryptexs: [Cryptex] = []
}

extension CryptexController {
	
}
