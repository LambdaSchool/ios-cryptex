//
//  CryptexViewController.swift
//  Cryptex
//
//  Created by Seschwan on 5/14/19.
//  Copyright © 2019 Seschwan. All rights reserved.
//

import UIKit

class CryptexViewController: UIViewController, UIPickerViewDelegate {

    // MARK: - Outlets
    @IBOutlet weak var hintLbl:     UILabel!
    @IBOutlet weak var pickerView:  UIPickerView!
    @IBOutlet weak var unlockBtn:   UIButton!
    
    
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
        unlockBtn.layer.cornerRadius = unlockBtn.frame.height/2
        pickerView.layer.cornerRadius = 15
        pickerView.dataSource   = self
        pickerView.delegate     = self
        updateViews()
        pickerView.showsSelectionIndicator = true
    }
    

    
    @IBAction func unlockBtnPressed(_ sender: UIButton) {
        if hasMatchingPassword() {
            presentCorrectPasswordAlert()
        } else {
            presentIncorrectPasswordAlert()
        }
        
    }
    
    func updateViews() {
        hintLbl.text = cryptexController.currentCryptex?.hint
        pickerView.reloadAllComponents()
    }
    
    func hasMatchingPassword () -> Bool {
        guard let currentCryptex = cryptexController.currentCryptex else { return false }
        var passwordArray: [String] = []
        for letter in 0..<currentCryptex.password.count {
            let row = pickerView.selectedRow(inComponent: letter)
            guard let title = pickerView(pickerView, titleForRow: row, forComponent: letter) else { continue }
            passwordArray.append(title)
        }
        let passwordGuess = passwordArray.joined()
        if passwordGuess.lowercased() == currentCryptex.password.lowercased() {
            return true
        } else {
            return false
        }
    }
    
    func reset() {
        countdownTimer?.invalidate()
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 60, repeats: false, block: { ( action ) in self.presentNoTimeRemainingAlert() } )
        for i in 0..<pickerView.numberOfComponents {
            pickerView.selectRow(letters.count/2, inComponent: i, animated: true)
            
            
        }
    }
    
    func newCryptexAndReset() {
        cryptexController.randomCryptex()
        updateViews()
        reset()
    }
    
    func presentCorrectPasswordAlert() {
        let correctAlert = UIAlertController(title: "Correct!", message: "Well done!", preferredStyle: .alert)
        correctAlert.addAction(UIAlertAction(title: "Try another..", style: .default, handler: { (action) in self.newCryptexAndReset() }))
        present(correctAlert, animated: true)
    }
    
    func presentIncorrectPasswordAlert() {
        let incorrectAlert = UIAlertController(title: "Wrong!", message: "Try Again!", preferredStyle: .alert)
        incorrectAlert.addAction(UIAlertAction(title: "Keep Trying", style: .default, handler: nil))
        incorrectAlert.addAction(UIAlertAction(title: "Try Another One", style: .default, handler: { (action) in
            self.newCryptexAndReset()
        }))
        present(incorrectAlert, animated: true)
    }
    
    func presentNoTimeRemainingAlert() {
        let outOfTimeAlert = UIAlertController(title: "OUT OF TIME", message: "You ran out of time", preferredStyle: .alert)
        outOfTimeAlert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: { (action) in self.reset() }))
        outOfTimeAlert.addAction(UIAlertAction(title: "Try Another One", style: .default, handler: { (action) in self.newCryptexAndReset() }))
        present(outOfTimeAlert, animated: true)
    }
}

//MARK: - UIPickerViewDataSource
extension CryptexViewController: UIPickerViewDataSource {
    
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
