//
//  CryptexViewController.swift
//  Cryptex
//
//  Created by Jeffrey Carpenter on 5/1/19.
//  Copyright © 2019 Jeffrey Carpenter. All rights reserved.
//

import UIKit

class CryptexViewController: UIViewController {

    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var unlockButton: UIButton!
    
    var cryptexController = CryptexController()
    var letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
                   "N", "O", "P", "Q", "R", "S", "T","U", "V", "W", "X", "Y", "Z"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.dataSource = self
        pickerView.delegate = self
        updateViews()
    }
    
    @IBAction func unlockButtonPressed(_ sender: UIButton) {
    }
    
    func updateViews() {
        
        guard let currentCryptex = cryptexController.currentCryptex else { return }
        
        hintLabel.text = currentCryptex.hint
        pickerView.reloadAllComponents()
    }
}

extension CryptexViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        guard let currentCryptex = cryptexController.currentCryptex else { return 0 }
        
        return currentCryptex.password.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return letters.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return letters[row]
    }
}
