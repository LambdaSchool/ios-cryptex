//
//  CryptexViewController.swift
//  Cryptex
//
//  Created by Jonathan Ferrer on 5/1/19.
//  Copyright © 2019 Jonathan Ferrer. All rights reserved.
//

import UIKit
class CryptexViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    var cryptexController: CryptexController?
    
    var letters = ["A", "B", "C", "D",
                   "E", "F", "G", "H",
                   "I", "J", "K", "L",
                   "M", "N", "O", "P",
                   "Q", "R", "S", "T",
                   "U", "V", "W", "X",
                   "Y", "Z"]

    override func viewDidLoad() {
        super.viewDidLoad()

        cryptexPickerView.delegate = self
        cryptexPickerView.dataSource = self
        
        updateViews()
        
    }
    //MARK: - Functions
    @IBAction func unlockButtonPressed(_ sender: Any) {
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // For the number of components, think about how you can figure out how many characters are in the `currentCryptex`'s password.
        guard let cryptex = cryptexController?.currentCryptex else { return 0 }
        return cryptex.password.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // For the number of rows, we want to show as many rows as there are letters.
        return letters.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // For the title of each row, we want to show the letter that corresponds to the row. i.e. row 0 should show "A", row 1 should show "B", etc.
        return letters[row]
    }
    func updateViews() {
        guard let cryptexHint = cryptexController?.currentCryptex?.hint else { return }
        
        cryptexLabel.text = cryptexHint
        
        cryptexPickerView.reloadAllComponents()
        
        
    }
    
    
    
    
    @IBOutlet weak var cryptexLabel: UILabel!
    @IBOutlet weak var cryptexPickerView: UIPickerView!
    @IBOutlet weak var unlockButton: UIButton!
    
    
    
    
}
