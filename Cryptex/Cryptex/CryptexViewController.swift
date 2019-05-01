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
    }
    
    func updateViews() {
        
        hintLabel.text = cryptexController.currentCryptex?.hint
        letterPickerView.reloadAllComponents()
    }
    
    @IBAction func unlockButtonTapped(_ sender: Any) {
        if hasMatchingPassword() {
            presentCorrectPasswordAlert()
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
    
    @objc func hasMatchingPassword() -> Bool {
        var lettersInView: [String] = []
        var guess = ""
        for i in 0..<letterPickerView.numberOfComponents {
            lettersInView.append(letters[letterPickerView.selectedRow(inComponent: i)])
            guess += letters[letterPickerView.selectedRow(inComponent: i)]
        }
        return guess.uppercased() == cryptexController.currentCryptex?.password.uppercased()
    }
    
    @ objc func myPrint() {
        print("Time!")
    }

    func reset() {
        countdownTimer?.invalidate()
        countdownTimer = Timer.scheduledTimer(timeInterval: 0.07, target: self, selector: #selector(myPrint), userInfo: nil, repeats: true)
    }
    
    func newCryptexAndReset() {
        cryptexController.randomCryptex()
        updateViews()
        reset()
    }
    
    // MARK: - Alerts
    
    func presentCorrectPasswordAlert() {
        let alert = UIAlertController(title: "You got it!", message: "That was the correct password.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
