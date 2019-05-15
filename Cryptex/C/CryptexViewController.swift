//
//  CryptexViewController.swift
//  Cryptex
//
//  Created by Nathan Hedgeman on 5/14/19.
//  Copyright © 2019 Nate Hedgeman. All rights reserved.
//

import UIKit

class CryptexViewController: UIViewController {
    
    
    
    var cryptexController = CryptexController()
    
    var letters = ["A", "B", "C", "D",
                   "E", "F", "G", "H",
                   "I", "J", "K", "L",
                   "M", "N", "O", "P",
                   "Q", "R", "S", "T",
                   "U", "V", "W", "X",
                   "Y", "Z"]
    
    //MARK: Outletss
    @IBOutlet weak var Picker: UIPickerView!
    @IBOutlet weak var HintLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Picker.dataSource = self
        Picker.delegate = self
        // Do any additional setup after loading the view.
        self.Picker.becomeFirstResponder()
        updateViews()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func UnlockButton(_ sender: Any) {
    }
    
}

extension CryptexViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    

    //MARK: Picker View Handling
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
    
    // Sets Hint Label's Text
    func updateViews() {
        HintLabel.text = cryptexController.currentCryptex?.hint
        reloadInputViews()
    }
}
