//
//  CryptexViewController.swift
//  cryptex
//
//  Created by Michael Flowers on 5/1/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

class CryptexViewController: UIViewController {
    
    let cc = CryptexController()
    var letters = ["A", "B", "C", "D",
                   "E", "F", "G", "H",
                   "I", "J", "K", "L",
                   "M", "N", "O", "P",
                   "Q", "R", "S", "T",
                   "U", "V", "W", "X",
                   "Y", "Z"]
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var buttonProperties: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        updateViews()
    }
    
    @IBAction func unlockButton(_ sender: UIButton) {
    }
    
    func updateViews(){
        label.text = cc.currentCryptex?.hint
        pickerView.reloadAllComponents() //if we don't do this, when a new random cyrptex is started, the picker view won't update to show the (potential) new numbers of components
    }
}

//MARK: - PICKER VIEW DATA SOURCE AND DELEGATE
extension CryptexViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        //this sets how many columns or how wide the pickerview is, think width
        return cc.currentCryptex?.password.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //this sets up how many choices are in each column so think the height part of the pickerview
        return letters.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let letter = letters[row]
        return letter
    }
}
