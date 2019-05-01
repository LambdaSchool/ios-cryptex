//
//  CryptexViewController.swift
//  Cryptex
//
//  Created by Ryan Murphy on 5/1/19.
//  Copyright © 2019 Ryan Murphy. All rights reserved.
//

import UIKit

class CryptexViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
  
    let cryptextController = CryptextController()
    // outlets
    @IBOutlet weak var cryptextPickerView: UIPickerView!
    @IBOutlet weak var hintLabel: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cryptextPickerView.delegate = self
        self.cryptextPickerView.dataSource = self
        updateViews()
    
    }
    
    var letters = ["A", "B", "C", "D",
                   "E", "F", "G", "H",
                   "I", "J", "K", "L",
                   "M", "N", "O", "P",
                   "Q", "R", "S", "T",
                   "U", "V", "W", "X",
                   "Y", "Z"]
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // functs for view
    func updateViews() {
        if let currentHint = cryptextController.currentCryptext?.hint {
            hintLabel.text = currentHint
    }
        cryptextPickerView.reloadAllComponents()
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // For the number of components, think about how you can figure out how many characters are in the `currentCryptex`'s password.
        return cryptextController.currentCryptext!.password.count
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // For the number of rows, we want to show as many rows as there are letters.
        return letters.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // For the title of each row, we want to show the letter that corresponds to the row. i.e. row 0 should show "A", row 1 should show "B", etc.
        return letters[row]
    }
    // game logic
    private func hasMatchingPassword() -> Bool {
        
        // Get the title of each row (which should be a single letter) in the picker view (try using a for-in loop) and store each one in an array.
        
        guard let currentPassword = cryptextController.currentCryptext else { return false }
        
        var characters: [String] = []
        
        for i in 0 ... currentPassword.password.count {
            
            let row = cryptextPickerView.selectedRow(inComponent: i)
            
            
            guard let title = pickerView(cryptextPickerView, titleForRow: row, forComponent: i) else { continue }
                characters.append(title)
        }


        //combine array into a single string.
        
        let word = characters.joined().lowercased()
        
        //lower case and return bool
        return word == currentPassword.password.lowercased()
    }
    
    @IBAction func unlockButtonPressed(_ sender: Any) {
    }

}
