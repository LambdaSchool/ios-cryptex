//
//  CryptexController.swift
//  Cryptex
//
//  Created by Michael Redig on 5/1/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import Foundation

class CryptexController {
	private var cryptices = [Cryptex]()
	
	var currentCryptex: Cryptex?
	
	fileprivate let defaultsKey = "cryptices"
	
	
	init() {
		loadCryptices()
		if cryptices.count == 0 {
			createCryptex(hint: "Stupid OS", password: "Windows", time: 60 * 5)
			createCryptex(hint: "Common pet", password: "cat", time: 60)
			createCryptex(hint: "A ____ in the hand is worth two in the bush", password: "bird", time: 60 * 2)
		}
		randomizeCryptex()
	}
	
	func createCryptex(hint: String, password: String, time: TimeInterval) {
		cryptices.append(Cryptex(password: password, hint: hint, time: time))
		saveCryptices()
	}
	
	
	func randomizeCryptex() {
		currentCryptex = cryptices.randomElement()
	}
	
	//MARK: saving and loading
	func loadCryptices() {
		let decoder = PropertyListDecoder()
		let defaults = UserDefaults.standard
		do {
			if let data = defaults.data(forKey: defaultsKey) {
				cryptices = try decoder.decode([Cryptex].self, from: data)
			}
		} catch {
			print("There was an error loading: \(error)")
		}

	}
	
	func saveCryptices() {
		let encoder = PropertyListEncoder()
		let defaults = UserDefaults.standard
		do {
			let data = try encoder.encode(cryptices)
			defaults.set(data, forKey: defaultsKey)
		} catch {
			print("There was an error saving: \(error)")
		}
	}
}
