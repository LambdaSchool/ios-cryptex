//
//  CryptexController.swift
//  Cryptex
//
//  Created by Hector Steven on 5/1/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation


class CryptexController {
	
	func createCryptex(password: String, hint: String) {
		cryptexs.append(Cryptex(password: password, hint: hint))
		saveToPersistentStore()
	}
	
	func randomCryptex(){
		if let randomCryptex = cryptexs.randomElement() {
			currentCryptex = randomCryptex
		}
	}
	
	init() {
//		cryptexs.append(Cryptex(password: "cryptex", hint: "The thing you are trying to solve right now"))
//		cryptexs.append(Cryptex(password: "lambda", hint: "The name of your school"))
		cryptexs.append(Cryptex((password: "hector", hint: "Who created this file"))
//		cryptexs.append(Cryptex(password: "alert", hint: "If you win or run out of time you will get an"))
//		cryptexs.append(Cryptex(password: "code", hint: "The code is a code"))
//		cryptexs.append(Cryptex(password: "endGame", hint: "What Avenger Movie is out Right now"))
//		cryptexs.append(Cryptex(password: "zyxwv", hint: "The last 5 letters"))
//		cryptexs.append(Cryptex(password: "h", hint: "I wonder. .."))
		loadFromPersistentStore()
		randomCryptex()
	}
	
	
	
	var currentCryptex: Cryptex?
	private(set) var cryptexs: [Cryptex] = []
}

extension CryptexController {
	private var cryptextListURL: URL? {
		let fileManager = FileManager.default
		guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
		let fileName = "cryptexts.plist"
		let document = documents.appendingPathComponent(fileName)

		return document
	}
	
	func saveToPersistentStore() {
		guard let url = cryptextListURL else { return }
		do {
			let encoder = PropertyListEncoder()
			let data = try encoder.encode(cryptexs)
			try data.write(to: url)
		} catch {
			NSLog("Error saving book data: \(error)")
		}
	}
	
	func loadFromPersistentStore() {
		let fileManager = FileManager.default
		guard let url = cryptextListURL,
			fileManager.fileExists(atPath: url.path) else {
				print("error: loadFromPersistentStore()")
				return
		}
		
		do {
			let data = try Data(contentsOf: url)
			let decoder = PropertyListDecoder()
			let decodedBooks = try decoder.decode([Cryptex].self, from: data)
			cryptexs = decodedBooks
		}catch {
			NSLog("Error loading book data: \(error)")
		}
	}
	
	
}
