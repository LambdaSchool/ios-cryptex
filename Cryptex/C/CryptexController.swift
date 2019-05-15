//
//  CryptexController.swift
//  Cryptex
//
//  Created by Nathan Hedgeman on 5/14/19.
//  Copyright © 2019 Nate Hedgeman. All rights reserved.
//

import Foundation

class CryptexController {
    
    init() {
        
        create(password: "Nathan", hint: "My Name")
        create(password: "Lambda", hint: "My School")
        create(password: "Mew", hint: "Best Pokemon")
    }
    
    private (set) var cryptexes: [Cryptex] = []
    
    func create (password: String, hint: String) {
        
        let crypt = Cryptex(password: password, hint: hint)
        
        cryptexes.append(crypt)
        
    }

    
}



//class NoteController {
//
//    init () {
//        //        createNote(withText: "Walk it")
//        //        createNote(withText: "This is it")
//        //        createNote(withText: "Last Call")
//    }
//    private(set) var notes: [Note] = []
//
//    func createNote(withText text: String) {
//        let note = Note(text: text)
//
//        notes.append(note)
//    }
//}
