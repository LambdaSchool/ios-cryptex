//
//  CryptexViewController.swift
//  Cryptex
//
//  Created by Ryan Murphy on 5/1/19.
//  Copyright © 2019 Ryan Murphy. All rights reserved.
//

import UIKit

class CryptexViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
  
    let cryptext = CryptextController()
    
    @IBOutlet weak var cyrptexPickerView: UIPickerView!
    @IBOutlet weak var hintLabel: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cyrptexPickerView.delegate = self
        self.cyrptexPickerView.dataSource = self
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
    
    func updateViews() {
        if let currentHint = cryptext.currentCryptext?.hint {
            hintLabel.text = currentHint
    }
        cyrptexPickerView.reloadAllComponents()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        
        // For the number of components, think about how you can figure out how many characters are in the `currentCryptex`'s password.
        
        return cryptext.currentCryptext!.password.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // For the number of rows, we want to show as many rows as there are letters.
        
        return letters.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // For the title of each row, we want to show the letter that corresponds to the row. i.e. row 0 should show "A", row 1 should show "B", etc.
        
        return letters[row]
    }
    
    
    
    
    @IBAction func unlockButtonPressed(_ sender: Any) {
    }
}
