//
//  CryptexViewController.swift
//  Cryptex
//
//  Created by Jeremy Taylor on 5/8/19.
//  Copyright © 2019 Bytes-Random L.L.C. All rights reserved.
//

import UIKit

class CryptexViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var hintLabel: UILabel!
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
    }
    
    @IBAction func unlockButtonTapped(_ sender: Any) {
        if hasMatchingPassword() {
            presentCorrectPasswordAlert()
        } else {
            presentIncorrectPasswordAlert()
        }
    }
    
    private func updateViews() {
        pickerView.reloadAllComponents()
        hintLabel.text = cryptexController.currentCryptex?.hint
    }
    
    private func hasMatchingPassword() -> Bool {
        let numberOfLetters = pickerView.numberOfComponents
        var enteredPassword: [String] = []
        for letter in 0..<numberOfLetters {
            let currentLetter = pickerView.selectedRow(inComponent: letter)
            enteredPassword.append(letters[currentLetter])
        }
        let enteredPasswordString = enteredPassword.joined(separator: "").lowercased()
        guard let currentCryptexPassword = cryptexController.currentCryptex?.password else { fatalError() }
        if enteredPasswordString == currentCryptexPassword.lowercased() {
            return true
        }
        return false
    }
    
    private func reset() {
        if let countdownTimer = countdownTimer {
            countdownTimer.invalidate()
        }
        _ = Timer.scheduledTimer(withTimeInterval: 60.00, repeats: false) { (countdownTimer) in
            self.presentNoTimeRemainingAlert()
        }
        
        for component in 0..<pickerView.numberOfComponents {
            pickerView.selectRow(0, inComponent: component, animated: true)
        }
    }
    
    private func newCryptexAndReset() {
        cryptexController.randomCryptex()
        reset()
        updateViews()
    }
    
    private func presentCorrectPasswordAlert() {
        let alertController = UIAlertController(title: "Correct!", message: "You guessed the correct password. Good job!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Try new Cryptex?", style: .default, handler: { (alert) in
            self.newCryptexAndReset()
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    private func presentIncorrectPasswordAlert() {
        let alertController = UIAlertController(title: "Incorrect", message: "You guessed the wrong password.", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Guess Again?", style: .cancel))
        
        alertController.addAction(UIAlertAction(title: "Try new Cryptex?", style: .default, handler: { (alert) in
            self.newCryptexAndReset()
        }))
        present(alertController, animated: true, completion: nil)
        
    }
    
    private func presentNoTimeRemainingAlert() {
        let alert = UIAlertController(title: "Time is up!", message: "Your time is expired. Would you like more time?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Reset timer", style: .default, handler: { (alert) in self.reset()}))
        alert.addAction(UIAlertAction(title: "Try new Cryptex", style: .default, handler: { (alert) in self.newCryptexAndReset()}))
        present(alert, animated: true, completion: nil)
    }
}

extension CryptexViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // For the number of components, think about how you can figure out how many characters are in the `currentCryptex`'s password.
        guard let currentCryptex = cryptexController.currentCryptex else { return 0 }
        return currentCryptex.password.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // For the number of rows, we want to show as many rows as there are letters.
        return letters.count
    }
}

extension CryptexViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // For the title of each row, we want to show the letter that corresponds to the row. i.e. row 0 should show "A", row 1 should show "B", etc.
        return letters[row]
    }
}
