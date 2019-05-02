//
//  CryptexViewController.swift
//  Cryptex
//
//  Created by morse on 5/1/19.
//  Copyright © 2019 morse. All rights reserved.
//

import UIKit

class CryptexViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet var hintLabel: UILabel!
    @IBOutlet var letterPickerView: UIPickerView!
    @IBOutlet var unlockButton: UIButton!
    
    let cryptexController = CryptexController()
    var countdownTimer: Timer?
    let letters = ["A", "B", "C", "D",
                   "E", "F", "G", "H",
                   "I", "J", "K", "L",
                   "M", "N", "O", "P",
                   "Q", "R", "S", "T",
                   "U", "V", "W", "X",
                   "Y", "Z"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        letterPickerView.delegate = self
        letterPickerView.dataSource = self
        updateViews()
        reset()
    }
    
    func updateViews() {
        
        hintLabel.text = cryptexController.currentCryptex?.hint
        letterPickerView.reloadAllComponents()
    }
    
    @IBAction func unlockButtonTapped(_ sender: Any) {
        if hasMatchingPassword() {
            presentCorrectPasswordAlert()
        } else {
            presentIncorrectPasswordAlert()
        }
    }
    
    // MARK: - Show a Cryptex
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // For the number of components, think about how you can figure out how many characters are in the `currentCryptex`'s password.
        guard let password = cryptexController.currentCryptex?.password else { return 0 } // Is this else right?
        
        return password.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // For the number of rows, we want to show as many rows as there are letters.
        return letters.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // For the title of each row, we want to show the letter that corresponds to the row. i.e. row 0 should show "A", row 1 should show "B", etc.
        return letters[row]
    }
    
    // MARK: - Game Logic
    
    func hasMatchingPassword() -> Bool {
        var guess = ""
        for i in 0..<letterPickerView.numberOfComponents {
            // Gets the letter at the same index that the component is at.
            let letter = letters[letterPickerView.selectedRow(inComponent: i)]
            guess += letter
        }
        return guess.uppercased() == cryptexController.currentCryptex?.password.uppercased()
    }

    func reset() {
        countdownTimer?.invalidate()
        // Selectors are the only thing that need objc funcitons
        countdownTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(presentNoTimeRemainingAlert), userInfo: nil, repeats: false)
    }
    
    func newCryptexAndReset() {
        cryptexController.randomCryptex()
        updateViews()
        reset()
    }
    
    // MARK: - Alerts
    
    func presentCorrectPasswordAlert() {
        let alert = UIAlertController(title: "You got it!", message: "That was the correct password.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "New Cryptex", style: .default, handler: { (_) in
            self.newCryptexAndReset()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func presentIncorrectPasswordAlert() {
        let alert = UIAlertController(title: "Sorry", message: "That's not quite right.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Keep Trying", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "New Cryptex", style: .default, handler: { (_) in
            self.newCryptexAndReset()
        }))
        present(alert, animated: true)
    }
    
    @ objc func presentNoTimeRemainingAlert() {
        let alert = UIAlertController(title: "Time Ran Out", message: "You'll have to be faster.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Keep Trying", style: .default, handler: { (_) in
            self.reset()
        }))
        alert.addAction(UIAlertAction(title: "New Cryptex", style: .default, handler: { (_) in
            self.newCryptexAndReset()
        }))
        present(alert, animated: true)
    }
}
