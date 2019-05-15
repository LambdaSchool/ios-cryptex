//
//  CryptexViewController.swift
//  Cryptex
//
//  Created by Dongwoo Pae on 5/13/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

class CryptexViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var cryptexPickerView: UIPickerView!
    @IBOutlet weak var unlockButtonLabel: UIButton!

    var letters = ["A", "B", "C", "D",
                   "E", "F", "G", "H",
                   "I", "J", "K", "L",
                   "M", "N", "O", "P",
                   "Q", "R", "S", "T",
                   "U", "V", "W", "X",
                   "Y", "Z"]
    
    
    var cryptexController = CryptexController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self .cryptexPickerView.dataSource = self
        self.cryptexPickerView.delegate = self
        
        updateViews()
    }

    
    
    @IBAction func unlockButtonTapped(_ sender: Any) {
        
    }

    
    func updateViews() {
        guard let hint = cryptexController.currentCryptex?.hint else {return}
            self.hintLabel.text = hint
            cryptexPickerView.reloadAllComponents()
    }

}


extension CryptexViewController {


    func numberOfComponents(in pickerView: UIPickerView) -> Int {
    // For the number of components, think about how you can figure out how many characters are in the `currentCryptex`'s password.
        return self.cryptexController.currentCryptex?.password.count ?? 0
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    // For the number of rows, we want to show as many rows as there are letters.
        return self.letters.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    // For the title of each row, we want to show the letter that corresponds to the row. i.e. row 0 should show "A", row 1 should show "B", etc.
        return letters[row]
    }
}
