//
//  ViewController.swift
//  Cryptex
//
//  Created by Christopher Aronson on 5/1/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

import UIKit

class CryptexViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var unlockButton: UIButton!
    
    var cryptexController = CryptexController()
    var countdownTimer: Timer?
    
    var letters = ["A", "B", "C", "D",
                   "E", "F", "G", "H",
                   "I", "J", "K", "L",
                   "M", "N", "O", "P",
                   "Q", "R", "S", "T",
                   "U", "V", "W", "X",
                   "Y", "Z"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        updateViews()
        reset()
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        guard let components = cryptexController.currentCryptex?.password.count else { return 0 }
        return components
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
        hintLabel.text = cryptexController.currentCryptex?.hint
        self.pickerView.reloadAllComponents()
        resetPickView()
    }
    
    func getChoice() -> String {
        var pickedCharacters: [String] = []
        
        if let range = cryptexController.currentCryptex?.password.count {
            for i in 0...(range - 1) {
                pickedCharacters.append(letters[pickerView.selectedRow(inComponent: i)])
            }
        }
        return pickedCharacters.joined()
    }
    
    func hasMatchingPassword() -> Bool {
        
        if cryptexController.currentCryptex?.password == getChoice() {
            return true
        } else {
            return false
        }
    }
    
    func resetPickView() {
        
        if let range = cryptexController.currentCryptex?.password.count {
            for i in 0...(range - 1) {
                self.pickerView.selectRow(0, inComponent: i, animated: true)
            }
        }
    }
    
    func reset() {
        
        countdownTimer?.invalidate()
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true, block: (timerHandler(timer:)))
        
    }
    
    func timerHandler(timer: Timer) {
        presentNoTimeRemainingAlert()
        print("Time out")
    }
    
    func newCryptexAndReset() {
        
        cryptexController.currentCryptex = cryptexController.randomCryptex()
        updateViews()
        reset()
    }
    
    func presentCorrectPasswordAlert() {
        
        let alert = UIAlertController(title: "Correct", message: "You guessed the password corectly", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: (alerHandler(alert:))))
        present(alert, animated: true, completion: nil)
    }
    
    func alerHandler(alert: UIAlertAction) {
        newCryptexAndReset()
    }
    
    func outOfTimeHandler(alert: UIAlertAction) {
        reset()
    }
    
    func presentIncorrectPasswordAlert() {
        
        let alert = UIAlertController(title: "Guess Again", message: "Sorry you guessed incorrectly", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Guess Again", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "New Cryptex", style: .default, handler: (alerHandler(alert:))))
        present(alert, animated: true, completion: nil)
    }
    
    func presentNoTimeRemainingAlert() {
        
        let alert = UIAlertController(title: "Time Out", message: "Sorry you ran out of time", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Reset Timer", style: .default, handler: (outOfTimeHandler(alert:))))
        alert.addAction(UIAlertAction(title: "New Cryptex", style: .default, handler: (alerHandler(alert:))))
        present(alert, animated: true, completion: nil)
    }

    @IBAction func unlockButtonPressed(_ sender: Any) {

        if hasMatchingPassword() {
            presentCorrectPasswordAlert()
            
        } else {
            presentIncorrectPasswordAlert()
        }
    }
    
}
