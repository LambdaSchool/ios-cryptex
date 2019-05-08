//
//  CryptexViewController.swift
//  Cryptex
//
//  Created by Jonathan Ferrer on 5/8/19.
//  Copyright © 2019 Jonathan Ferrer. All rights reserved.
//

import UIKit

class CryptexViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        cryptexPickerView.dataSource = self
        cryptexPickerView.delegate = self
        updateViews()

        // Do any additional setup after loading the view.
    }



    // MARK: - Methods
    @IBAction func unlockButtonPressed(_ sender: Any) {
        if hasMatchingPassword() {
            presentCorrectPasswordAlert()
        } else {
            presentIncorrectPasswordAlert()
        }

    }

    func presentCorrectPasswordAlert() {
        let alert = UIAlertController(title: "Unlocked!", message: "You have successfully unlocked the cryptex!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try a new cryptex", style: .default, handler: { (alert) in
            self.newCryptexAndReset()}))
        present(alert, animated: true, completion: nil)
    }

    func presentIncorrectPasswordAlert() {
        let alert = UIAlertController(title: "Incorrect", message: "You have entered an incorrect password.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue trying", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Try a new cryptex", style: .default, handler: { (alert) in
            self.newCryptexAndReset()}))
        present(alert, animated: true, completion: nil)
    }

    func presentNoTimeRemainingAlert() {
        let alert = UIAlertController(title: "Time up", message: "You have ran out of time!!!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Reset Timer", style: .default, handler: { (alert) in
            self.reset()}))
        alert.addAction(UIAlertAction(title: "Try a new cryptex", style: .default, handler: { (alert) in
            self.newCryptexAndReset()
        }))
        present(alert, animated: true, completion: nil)
    }

    func reset(){
        countdownTimer?.invalidate()
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 60, repeats: false, block: { (countdownTimer) in
            self.presentIncorrectPasswordAlert()
        })

    }

    func newCryptexAndReset() {
        cryptexController.randomCryptex()
        updateViews()
        reset()


    }

    func hasMatchingPassword() -> Bool {
        let numberOfLetters = cryptexPickerView.numberOfComponents - 1

        var passwordEntered: [String] = []
        for letter in 0...numberOfLetters{
            let currentComponent = cryptexPickerView.selectedRow(inComponent: letter)
            passwordEntered.append(letters[currentComponent])
        }

        let passwordEnteredString = passwordEntered.joined(separator: "")

        if passwordEnteredString == cryptexController.currentCryptex?.password{
            return true
        } else {
            return false
        }
    }

    func updateViews() {
        hintLabel.text = cryptexController.currentCryptex?.hint
        cryptexPickerView.reloadAllComponents()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // For the number of components, think about how you can figure out how many characters are in the `currentCryptex`'s password.
        guard let currentCryptex = cryptexController.currentCryptex else { return 0}
        return currentCryptex.password.count
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // For the number of rows, we want to show as many rows as there are letters.
        return letters.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // For the title of  each row, we want to show the letter that corresponds to the row. i.e. row 0 should show "A", row 1 should show "B", etc.
        return letters[row]
    }




    // MARK: - Properties
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var cryptexPickerView: UIPickerView!
    var cryptexController = CryptexController()
    var letters = ["A", "B", "C", "D",
                   "E", "F", "G", "H",
                   "I", "J", "K", "L",
                   "M", "N", "O", "P",
                   "Q", "R", "S", "T",
                   "U", "V", "W", "X",
                   "Y", "Z"]

    var countdownTimer: Timer?
}
