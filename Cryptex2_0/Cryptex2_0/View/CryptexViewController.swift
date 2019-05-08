//
//  CryptexViewController.swift
//  Cryptex2_0
//
//  Created by Kobe McKee on 5/8/19.
//  Copyright © 2019 Kobe McKee. All rights reserved.
//

import UIKit

class CryptexViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var cryptexController = CryptexController()
    
    
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var cryptexPicker: UIPickerView!
    
    @IBAction func unlockButtonPressed(_ sender: UIButton) {
        
        if hasMatchingPassword() {
            presentCorrectPasswordAlert()
        }
        else {
            presentIncorrectPasswordAlert()
        }
        
    }
    
    func updateViews() {
        
        guard let cryptex = cryptexController.currentCryptex else { return }
        hintLabel.text = cryptex.hint
        
        cryptexPicker.reloadAllComponents()
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        cryptexPicker.delegate = self
        cryptexPicker.dataSource = self
        updateViews()
        
    }
    
    
    var letters = ["A", "B", "C", "D",
                   "E", "F", "G", "H",
                   "I", "J", "K", "L",
                   "M", "N", "O", "P",
                   "Q", "R", "S", "T",
                   "U", "V", "W", "X",
                   "Y", "Z"]

    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        guard let cryptex = cryptexController.currentCryptex else { return 0 }
        return cryptex.password.count
    }

    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return letters.count
    }

    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return letters[row]
    }
    
    
    func hasMatchingPassword() -> Bool {
        
        guard let currentCryptex = cryptexController.currentCryptex else { return false }
        var characters: [String] = []
        
        
        for i in 0..<currentCryptex.password.count {
            let row = cryptexPicker.selectedRow(inComponent: i)
            guard let title = pickerView(cryptexPicker, titleForRow: row, forComponent: i) else { continue }
            characters.append(title)
        }
        
        
        let answer = characters.joined()
        if answer.lowercased() == currentCryptex.password.lowercased() { return true }
        else { return false }
        
    }
    
    
    
    var countdownTimer: Timer?
    
    
    func reset() {
        
        countdownTimer?.invalidate()
        countdownTimer = nil
        
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 60, repeats: false, block: {
            (action) in                              // (Timer)??? what goes here?
            self.presentNoTimeRemainingAlert()
            })
    
        for i in 0..<cryptexPicker.numberOfComponents {
            cryptexPicker.selectRow(0, inComponent: i, animated: true)
            
        }
    }
    
    func newCryptexAndReset() {
        
        cryptexController.randomCryptex()
        updateViews()
        reset()
        
    }
    
    
    
    func presentCorrectPasswordAlert() {
        
        let correctAlert = UIAlertController(title: "CORRECT", message: "You answered correctly", preferredStyle: .alert)
        correctAlert.addAction(UIAlertAction(title: "Next", style: .default, handler: {
            (action) in
            self.newCryptexAndReset()
        }))
        
        present(correctAlert, animated: true, completion: nil)
        
    }
    
    
    func presentIncorrectPasswordAlert() {
        
        let incorrectAlert = UIAlertController(title: "WRONG", message: "That is incorrect", preferredStyle: .alert)
        
        incorrectAlert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
        
        incorrectAlert.addAction(UIAlertAction(title: "Try New Cryptex", style: .default, handler: {
            (action) in
            self.newCryptexAndReset()
        }))
        
        present(incorrectAlert, animated: true, completion: nil)
        
    }
    
    
    func presentNoTimeRemainingAlert() {
        
        let noTimeAlert = UIAlertController(title: "OUT OF TIME", message: "You've run out of time", preferredStyle: .alert)
        
        noTimeAlert.addAction(UIAlertAction(title: "Reset Time?", style: .default, handler: {
            (aciton) in
            self.reset()
        }))
        
        noTimeAlert.addAction(UIAlertAction(title: "Try New Cryptex", style: .default, handler: {
            (action) in
            self.newCryptexAndReset()
        }))
        
        present(noTimeAlert, animated: true, completion: nil)
        
    }
    
    
    
    
}
