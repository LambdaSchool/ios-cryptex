//
//  CryptexController.swift
//  Cryptex
//
//  Created by Jeremy Taylor on 5/8/19.
//  Copyright © 2019 Bytes-Random L.L.C. All rights reserved.
//

import Foundation

class CryptexController {
    private(set) var cryptexs: [Cryptex] = []
    var currentCryptex: Cryptex?
    
    func randomCryptex() {
        let randomCryptex = cryptexs.randomElement()
        currentCryptex = randomCryptex
    }
    
    func createNewCryptex(withHint hint: String, withPassword password: String) {
        let cryptex = Cryptex(password: password, hint: hint)
        cryptexs.append(cryptex)
    }
    
    init() {
        loadFromPersistentStore()
        if cryptexs.isEmpty {
            let cryptex1 = Cryptex(password: "Spock", hint: "Famous Vulcan")
            let cryptex2 = Cryptex(password: "Constant", hint: "Its value can't be changed once set in code")
            let cryptex3 = Cryptex(password: "Elvis", hint: "One of this singer's hits was Hound Dog")
            
            cryptexs.append(cryptex1)
            cryptexs.append(cryptex2)
            cryptexs.append(cryptex3)
        }
        
        
        randomCryptex()
    }
    
    // MARK: - Persistence
    
    private var cryptexDataURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        print("Documents: \(documents.path)")
        return documents.appendingPathComponent("CryptexData.plist")
    }
    
    func saveToPersistentStore() {
        guard let url = cryptexDataURL else { return }
        let encoder = PropertyListEncoder()
        do {
            let cryptexData = try encoder.encode(cryptexs)
            try cryptexData.write(to: url)
        } catch {
            print("Error saving cryptexs: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        do {
            guard let url = cryptexDataURL else { return }
            let cryptexData = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedCryptexs = try decoder.decode([Cryptex].self, from: cryptexData)
            cryptexs = decodedCryptexs
        } catch {
            print("Error loading cryptexs: \(error)")
        }
    }
}
