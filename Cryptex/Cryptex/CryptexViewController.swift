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
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        
        presentAddCryptexAlert()
    }
    
    @IBAction func unlockButtonPressed(_ sender: UIButton) {
        
        if cryptexController.hasMatchingPassword(guess: guessToString()) {
            presentCorrectPasswordAlert()
        } else {
            presentIncorrectPasswordAlert()
        }
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
        countdownTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(presentNoTimeRemainingAlert), userInfo: nil, repeats: false)
        
        // Reset the pickerView
        for component in 0...(pickerView.numberOfComponents - 1) {
            pickerView.selectRow(0, inComponent: component, animated: true)
        }
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

// MARK: - AlertController methods

extension CryptexViewController {
    
    func presentCorrectPasswordAlert() {
        
        let alert = UIAlertController(title: "Correct!", message: "You guessed the Cryptex correctly.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "New Cryptex", style: .default, handler: { action in
            self.newCryptexAndReset()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func presentIncorrectPasswordAlert() {
        
        let alert = UIAlertController(title: "Incorrect", message: "You guess the Cryptex incorrectly.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { action in
            self.reset()
        }))
        alert.addAction(UIAlertAction(title: "New Cryptex", style: .default, handler: { action in
            self.newCryptexAndReset()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func presentNoTimeRemainingAlert() {
        
        let alert = UIAlertController(title: "Out of Time", message: "You didn't guess fast enough.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { action in
            self.reset()
        }))
        alert.addAction(UIAlertAction(title: "New Cryptex", style: .default, handler: { action in
            self.newCryptexAndReset()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func presentAddCryptexAlert() {
        
        let alert = UIAlertController(title: "Add a Cryptex", message: nil, preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: nil)
        alert.addTextField(configurationHandler: nil)
        alert.textFields![0].placeholder = "Answer"
        alert.textFields![1].placeholder = "Hint"
        
        let action = UIAlertAction(title: "Submit", style: .default) { [unowned alert] _ in
            guard let password = alert.textFields![0].text,
            let hint = alert.textFields![1].text
            else { return }
            self.cryptexController.createCryptex(with: password, hint: hint)
            self.newCryptexAndReset()
        }
        
        alert.addAction(action)
        
        present(alert, animated: true)
    }
}
