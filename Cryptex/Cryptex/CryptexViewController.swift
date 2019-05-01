//
//  CryptexViewController.swift
//  Cryptex
//
//  Created by morse on 5/1/19.
//  Copyright © 2019 morse. All rights reserved.
//

import UIKit

class CryptexViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet var hintLabel: UILabel!
    @IBOutlet var letterPickerView: UIPickerView!
    @IBOutlet var unlockButton: UIButton!
    
    let cryptexController = CryptexController()
    var letters = ["A", "B", "C", "D",
                   "E", "F", "G", "H",
                   "I", "J", "K", "L",
                   "M", "N", "O", "P",
                   "Q", "R", "S", "T",
                   "U", "V", "W", "X",
                   "Y", "Z"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        letterPickerView.delegate = self
        letterPickerView.dataSource = self
        updateViews()
    }
    
    func updateViews() {
        
        hintLabel.text = cryptexController.currentCryptex?.hint
        letterPickerView.reloadAllComponents()
    }
    
    @IBAction func unlockButtonTapped(_ sender: Any) {
    }
    
    // MARK: - Show a Cryptex

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // For the number of components, think about how you can figure out how many characters are in the `currentCryptex`'s password.
        guard let password = cryptexController.currentCryptex?.password else { return 0 } // Is this else right?
        
        return password.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // For the number of rows, we want to show as many rows as there are letters.
        return letters.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // For the title of each row, we want to show the letter that corresponds to the row. i.e. row 0 should show "A", row 1 should show "B", etc.
        return letters[row]
        
    }
    
    // MARK: = Game Logic
    
//    func hasMatchingPassword() -> Bool {
//        var letters: [Character] = []
//        
//        for letter in  {
//            
//        }
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
