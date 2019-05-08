//
//  CryptexViewController.swift
//  Crypyex
//
//  Created by Hayden Hastings on 5/8/19.
//  Copyright © 2019 Hayden Hastings. All rights reserved.
//

import UIKit

class CryptexViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        updateViews()
    }
    
    func updateViews() {
        guard let hint = cryptexController.currentCryptex?.hint else { return }
        hintLabel.text = hint
        
        pickerView.reloadAllComponents()
    }
    
    // MARK: Game Logic
    
    func hasMatchingPassword() -> Bool {
        guard let currentCryptex = cryptexController.currentCryptex else { return false }
        var characters: [String] = []
        
        for i in 0..<currentCryptex.password.count {
            let row = pickerView.selectedRow(inComponent: i)
            
            guard let title = pickerView(pickerView, titleForRow: row, forComponent: i) else { continue }
            characters.append(title)
        }
        
        let answer = characters.joined()
        
        if answer == currentCryptex.password {
            return true
        } else {
            return false
        }
    }
    
    func reset() {
        guard let timer = countdownTimer else { return }
        Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { timer in
            print("Timer has finished")
        }
    }
    
    func newCryptexAndRest() {
        cryptexController.randomCryptex()
        updateViews()
        reset()
    }
    
    // MARK: Properties
    
    @IBAction func unlockButtonPressed(_ sender: Any) {
        
    }
    
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var unlockButton: UIButton!
    
    var letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    var countdownTimer: Timer?
    var cryptexController = CryptexController()
}

extension CryptexViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        guard let currentCryptex = cryptexController.currentCryptex else { return 0 }
        return currentCryptex.password.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // For the number of rows, we want to show as many rows as there are letters.
        
        return letters[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // For the title of each row, we want to show the letter that corresponds to the row. i.e. row 0 should show "A", row 1 should show "B", etc.
        return letters[row]
    }
}

extension CryptexViewController: UIPickerViewDelegate {
    
}
