//
//  CryptexViewController.swift
//  Cryptex
//
//  Created by Ryan Murphy on 5/1/19.
//  Copyright © 2019 Ryan Murphy. All rights reserved.
//

import UIKit

class CryptexViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var cryptextPickerView: UIPickerView!
    @IBOutlet weak var hintLabel: UILabel!
    
    var cryptexController = CryptexController()
    @objc var countdownTimer: Timer?
    var letters = ["A", "B", "C", "D",
                   "E", "F", "G", "H",
                   "I", "J", "K", "L",
                   "M", "N", "O", "P",
                   "Q", "R", "S", "T",
                   "U", "V", "W", "X",
                   "Y", "Z"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cryptextPickerView.delegate = self
        cryptextPickerView.dataSource = self
        
        updateViews()
        
    }

        
    
    func presentCorrectPasswordAlert() {
        
        let alert = UIAlertController(title: "Correct!", message: "Congratulations, you got it!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try new cryptex", style: .default, handler: { (alert) in self.newCryptexAndReset()}))
        present(alert, animated: true, completion: nil)
        
    }
    
    func presentIncorrectPasswordAlert(){
        let alert = UIAlertController(title: "Wrong!", message: "Your guess was bad and you should feel bad ... keep trying.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue guessing!", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        
        
    }
    
    func presentNoTimeRemainingAlert() {
        
        let alert = UIAlertController(title: "No Time", message: "You have have ran out of time! Would you like to reset the Timer?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Reset timer", style: .default, handler: { (alert) in self.reset()}))
        alert.addAction(UIAlertAction(title: "Try new cryptex", style: .default, handler: { (alert) in self.newCryptexAndReset()}))
        present(alert, animated: true, completion: nil)
        
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // For the number of components, think about how you can figure out how many characters are in the `currentCryptex`'s password.
        guard let cryptex = cryptexController.currentCryptex else { return 0 }
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
        guard let cryptexHint = cryptexController.currentCryptex?.hint else { return }
        hintLabel.text = cryptexHint
        cryptextPickerView.reloadAllComponents()
    }
    func hasMatchingPassword() -> Bool{
        let numberOfLetters = cryptextPickerView.numberOfComponents - 1
        
        var passwordEntered: [String] = []
        for letter in 0...numberOfLetters{
            let currentComponent = cryptextPickerView.selectedRow(inComponent: letter)
            passwordEntered.append(letters[currentComponent])
        }
        
        let passwordEnteredString = passwordEntered.joined(separator: "")
        
        if passwordEnteredString == cryptexController.currentCryptex?.password{
            return true
        } else {
            return false
        }
    }
    
    func reset(){
        countdownTimer?.invalidate()
        _ = Timer.scheduledTimer(withTimeInterval: 60.00, repeats: false) { (countdownTimer) in
            self.presentNoTimeRemainingAlert()
        }
    }
    func newCryptexAndReset() {
        cryptexController.randomCryptex()
        updateViews()
        reset()
    }
    
    
    @IBAction func unlockButtonPressed(_ sender: Any) {
        if hasMatchingPassword(){
            presentCorrectPasswordAlert()
        } else {
            presentIncorrectPasswordAlert()
        }
        
    }

}

