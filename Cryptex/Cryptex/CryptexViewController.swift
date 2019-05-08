//
//  CryptexViewController.swift
//  Cryptex
//
//  Created by Mitchell Budge on 5/1/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//


import UIKit

class CryptexViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var cryptexController = CryptexController()
    
    @IBOutlet weak var cryptexPickerView: UIPickerView!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var unlockButton: UIButton!
    
    
    var letters = ["A", "B", "C", "D",
                   "E", "F", "G", "H",
                   "I", "J", "K", "L",
                   "M", "N", "O", "P",
                   "Q", "R", "S", "T",
                   "U", "V", "W", "X",
                   "Y", "Z"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cryptexPickerView.delegate = self
        cryptexPickerView.dataSource = self
        updateViews()
    }
    
    
    func updateViews() {
        guard let cryptex = cryptexController.currentCryptex else { return }
        hintLabel.text = cryptex.hint
        cryptexPickerView.reloadAllComponents()
        
    }
    
    
    
    @IBAction func unlockButtonPressed(_ sender: Any) {
        if hasMatchingPassword() {
            presentCorrectPasswordAlert()
        } else {
            presentIncorrectPasswordAlert()
        }
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        guard let currentCryptex = cryptexController.currentCryptex else { return 0}
        return currentCryptex.password.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 26
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return letters[row]
    }
    
    
    /*                              --Game Logic--                              */
    
    func hasMatchingPassword() -> Bool {
        guard let currentPassword = cryptexController.currentCryptex else {return false}
        var characters : [String] = []
        
        
        for i in 0..<currentPassword.password.count{
            let row = cryptexPickerView.selectedRow(inComponent: i)
            guard let title = pickerView(cryptexPickerView, titleForRow: row, forComponent: i) else { continue }
            characters.append(title)
        }
        
        let answer = characters.joined()
        if answer == cryptexController.currentCryptex?.password { return true } else { return false }
        
    }
    
    
    var countdownTimer: Timer?
    
    
    func reset() {
        countdownTimer?.invalidate()
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 60, repeats: false, block: { (Timer) in
            self.presentNoTimeRemainingAlert()
        })
        updateViews()
    }
    
    func newCryptexAndReset() {
        cryptexController.randomCryptex()
        updateViews()
        reset()
    }
    
    
    func presentCorrectPasswordAlert() {
        
        let correctAlert = UIAlertController(title: "Correct", message: "You answered correctly!", preferredStyle: .alert)
        correctAlert.addAction(UIAlertAction(title: "Next", style: .default, handler: {
            (action) in
            self.newCryptexAndReset()
            
        }))
        present(correctAlert, animated: true, completion: nil)
        
    }
    
    func presentIncorrectPasswordAlert() {
        
        let incorrectAlert = UIAlertController(title: "Incorrect", message: "You answered incorrectly. Try again!", preferredStyle: .alert)
        incorrectAlert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
        incorrectAlert.addAction(UIAlertAction(title: "Try New Cryptex", style: .default, handler: {
            (action) in
            self.newCryptexAndReset()
        }))
        present(incorrectAlert, animated: true, completion: nil)
    }
    
    func presentNoTimeRemainingAlert() {
        let noTimeAlert = UIAlertController(title: "Time is up", message: "You are out of time!", preferredStyle: .alert)
        noTimeAlert.addAction(UIAlertAction(title: "Reset timer?", style: .default, handler: {
            (action) in
            self.reset()
        }))
        noTimeAlert.addAction(UIAlertAction(title: "Try New Cryptex", style: .default, handler: {
            (action) in
            self.newCryptexAndReset()
        }))
        present(noTimeAlert, animated: true, completion: nil)
    }
    
    
}
