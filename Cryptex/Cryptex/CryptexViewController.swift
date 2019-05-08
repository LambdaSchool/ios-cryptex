//
//  CryptexViewController.swift
//  Cryptex
//
//  Created by Thomas Cacciatore on 5/8/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

import UIKit

class CryptexViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.dataSource = self
        pickerView.delegate = self
        updateViews()
    }
    

    func updateViews() {
        hintLabel.text = cryptexController.currentCryptex?.hint
        // reload components of the picker view
        pickerView.reloadAllComponents()
    }
    
    
    
    
    @IBAction func unlockButtonTapped(_ sender: Any) {
    }
    
    
    //Mark: Properties
    
    var cryptexController = CryptexController()
    
    var letters = ["A", "B", "C", "D",
                   "E", "F", "G", "H",
                   "I", "J", "K", "L",
                   "M", "N", "O", "P",
                   "Q", "R", "S", "T",
                   "U", "V", "W", "X",
                   "Y", "Z"]

    
    
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var unlockButton: UIButton!
    
    
}

extension CryptexViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        guard let componentCount = cryptexController.currentCryptex?.password.count else { return 0 }
        return componentCount
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return letters.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // For the title of each row, we want to show the letter that corresponds to the row. i.e. row 0 should show "A", row 1 should show "B", etc.
        var pickedLetter = ""
        pickedLetter = letters[row]
        
        return pickedLetter
    }

}

extension CryptexViewController: UIPickerViewDelegate {
    
}
