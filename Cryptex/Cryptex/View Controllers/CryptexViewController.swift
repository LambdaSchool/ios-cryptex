//
//  CryptexViewController.swift
//  Cryptex
//
//  Created by Lisa Sampson on 5/1/19.
//  Copyright © 2019 Lisa M Sampson. All rights reserved.
//

import UIKit

class CryptexViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var clueLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var unlockButton: UIButton!
    
    var cryptexController = CryptexController()
    
    var letters = ["A", "B", "C", "D",
                   "E", "F", "G", "H",
                   "I", "J", "K", "L",
                   "M", "N", "O", "P",
                   "Q", "R", "S", "T",
                   "U", "V", "W", "X",
                   "Y", "Z"]
    
    var countdownTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView.delegate = self
        pickerView.dataSource = self
        
        updateViews()
        reset()
    }
    
    func updateViews() {
        
        guard let currentCryptex = cryptexController.currentCryptex else { return }
        
        clueLabel.text = currentCryptex.hint
        pickerView.reloadAllComponents()
    }
    
    @IBAction func unlockButtonTapped(_ sender: Any) {
        
        if hasMatchingPassword(guess: <#T##String#>) {
            presentCorrectPasswordAlert()
        } else {
            presentIncorrectPasswordAlert()
        }
    }
    
    func presentCorrectPasswordAlert() {
        
        let alert = UIAlertController(title: "Congratulations!", message: "You have successfully guessed the password! Would you like to play again with a new cryptex?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "New cryptex", style: .default, handler: { action in
            self.newCryptexAndReset()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func presentIncorrectPasswordAlert() {
        
        let alert = UIAlertController(title: "Not quite!", message: "Would you like to keep guessing or try a new cryptex?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "New cryptex", style: .default, handler: { action in
            self.newCryptexAndReset()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func presentNoTimeRemainingAlert() {
        
        let alert = UIAlertController(title: "Out of time!", message: "You have ran out of time! Would you like to reset the timer and keep guessing or try a new cryptex?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Reset", style: .default, handler: { action in
            self.reset()
        }))
        alert.addAction(UIAlertAction(title: "New cryptex", style: .default, handler: { action in
            self.newCryptexAndReset()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func reset() {
        
        if let countdownTimer = countdownTimer {
            countdownTimer.invalidate()
        }
        
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 60, repeats: false, block: { (countdownTimer) in
            self.presentNoTimeRemainingAlert()
        })
    }
    
    func newCryptexAndReset() {
        
        cryptexController.randomCryptex()
        updateViews()
        reset()
    }
    
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
    
    func hasMatchingPassword(guess: String) -> Bool {
        
        guard let currentCryptex = cryptexController.currentCryptex else { return false }
        
        return guess.uppercased() == currentCryptex.password.uppercased()
    }

}
