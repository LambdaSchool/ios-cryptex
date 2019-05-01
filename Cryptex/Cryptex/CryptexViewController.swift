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
    var countdownTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        updateViews()
        reset()
    }
    
    @IBAction func unlockButtonPressed(_ sender: UIButton) {
        print(cryptexController.hasMatchingPassword(guess: guessToString()))
    }
    
    func updateViews() {
        
        guard let currentCryptex = cryptexController.currentCryptex else { return }
        
        hintLabel.text = currentCryptex.hint
        pickerView.reloadAllComponents()
    }
    
    func guessToString() -> String {
        
        var guessString = String()
        var guessArray = [String]()
        
        for componenet in 0...(pickerView.numberOfComponents - 1) {
            guessArray.append(letters[pickerView.selectedRow(inComponent: componenet)])
        }
        
        for letter in guessArray {
            guessString.append(letter)
        }
        
        return guessString
    }
    
    func reset() {
        
        // Invalidate old timer (if one exists)
        if let countdownTimer = countdownTimer {
            countdownTimer.invalidate()
        }
        
        // Start a new 60 second timer
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 60, repeats: false) { countdownTimer in
            print("Time is done!")
        }
        
        // TODO: Reset the pickerView
    }
    
    func newCryptexAndReset() {
        
        cryptexController.randomCryptex()
        updateViews()
        reset()
    }
}

    // MARK: - PickerView DataSource and Delegate Methods
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
