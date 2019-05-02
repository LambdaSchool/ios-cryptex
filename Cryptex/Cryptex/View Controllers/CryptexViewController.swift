//
//  CryptexViewController.swift
//  Cryptex
//
//  Created by Lisa Sampson on 5/1/19.
//  Copyright © 2019 Lisa M Sampson. All rights reserved.
//

import UIKit

class CryptexViewController: UIViewController {
    
    // MARK: - Properties and Outlets
    
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
    
    // MARK: - View Loading Functions
    
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
    
    // MARK: - Action Methods and Logic
    
    @IBAction func unlockButtonTapped(_ sender: Any) {
        
        if hasMatchingPassword(guess: <#T##String#>) {
            presentCorrectPasswordAlert()
        } else {
            presentIncorrectPasswordAlert()
        }
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
    
    func hasMatchingPassword(guess: String) -> Bool {
        
        guard let currentCryptex = cryptexController.currentCryptex else { return false }
        
        return guess.uppercased() == currentCryptex.password.uppercased()
    }

}
