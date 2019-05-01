//
//  CryptexViewController.swift
//  CryptexProject
//
//  Created by Thomas Cacciatore on 5/1/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

import UIKit

class CryptexViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var cryptexController = CryptexController()
    
    var letters = ["A", "B", "C", "D",
                   "E", "F", "G", "H",
                   "I", "J", "K", "L",
                   "M", "N", "O", "P",
                   "Q", "R", "S", "T",
                   "U", "V", "W", "X",
                   "Y", "Z"]
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // For the number of components, think about how you can figure out how many characters are in the `currentCryptex`'s password.
        return cryptexController.currentCryptex?.password.count ?? 0
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         // For the number of rows, we want to show as many rows as there are letters.
        return letters.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // For the title of each row, we want to show the letter that corresponds to the row. i.e. row 0 should show "A", row 1 should show "B", etc.
        
        return letters[row]

    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        updateViews()
        
    }
    
    func updateViews() {
        hintLabel.text = cryptexController.currentCryptex?.hint
        //reload components of the picker view
        pickerView.reloadAllComponents()
        
    }
    
    func hasMatchingPassword() -> Bool {
        //Get the letter for each row.
        guard let password = cryptexController.currentCryptex?.password else { return false }
        
        var lettersArray: [String] = []
        for number in 0..<password.count {
            let rowIndex = pickerView.selectedRow(inComponent: number)
    
            guard let letter = pickerView(pickerView, titleForRow: rowIndex, forComponent: number) else { continue }
            
            lettersArray.append(letter)
        }
        
        let word = lettersArray.joined().lowercased()
        
        if word == password {
           return true
        } else {
            return false
        }
    }
    //Store each letter in an array of strings
    
    
    @IBAction func unlockButtonTapped(_ sender: Any) {

    }
    
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var unlockButton: UIButton!

}
