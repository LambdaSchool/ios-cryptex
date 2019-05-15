//
//  CryptexViewController.swift
//  Cryptex
//
//  Created by Dongwoo Pae on 5/13/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

class CryptexViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    //IBOutlers
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var cryptexPickerView: UIPickerView!
    
    //properties
    var letters = ["A", "B", "C", "D",
                   "E", "F", "G", "H",
                   "I", "J", "K", "L",
                   "M", "N", "O", "P",
                   "Q", "R", "S", "T",
                   "U", "V", "W", "X",
                   "Y", "Z"]
   // var yourAnswer: [String] = []
    var countdownTimer: Timer?
    private var stopDate: Date?
    
    
    var cryptexController = CryptexController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self .cryptexPickerView.dataSource = self
        self.cryptexPickerView.delegate = self
        
        updateViews()
        
    }

    
    
    @IBAction func unlockButtonTapped(_ sender: Any) {
        hasMatchingPassword()
    }

    
    func updateViews() {
        guard let upperCase = cryptexController.currentCryptex else {return}
            self.hintLabel.text? = upperCase.hint.uppercased()
            cryptexPickerView.reloadAllComponents()
    }
    

}


extension CryptexViewController {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
    // For the number of components, think about how you can figure out how many characters are in the `currentCryptex`'s password.
        return self.cryptexController.currentCryptex?.password.count ?? 0
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    // For the number of rows, we want to show as many rows as there are letters.
        return self.letters.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    // For the title of each row, we want to show the letter that corresponds to the row. i.e. row 0 should show "A", row 1 should show "B", etc.
        return letters[row]
        
    }
    
 
   
    func hasMatchingPassword() -> Bool {
        //var output = ""
        var combinedLetters :[String] = []
        guard let count = cryptexController.currentCryptex else {return false}

            for input in 0..<count.password.count {
                let row = cryptexPickerView.selectedRow(inComponent: input)     //  ["a","b","c"]
                guard let title = pickerView(cryptexPickerView, titleForRow: row, forComponent: input) else {continue}
                combinedLetters.append(title)
        }
        let combinedLetterOneString = combinedLetters.joined().uppercased()
        guard let passwordUppercase = cryptexController.currentCryptex?.password.uppercased() else {return false}
        
        print(combinedLetterOneString)
        print(passwordUppercase)
        return combinedLetterOneString == passwordUppercase
    }
    
    func reset() {
    cancelTimer()
    }
    
    func cancelTimer() {
        // We must invalidate a timer, or it will continue to run even if we
        // start a new timer
        countdownTimer?.invalidate()
        countdownTimer = nil
    }
/*
    func start() {
        // Cancel timer before starting new timer
        cancelTimer()
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 60, repeats: false, block: { (_) in
          self.presentNoTimeRemainingAlert()
        })
    }
  */
    func newCryptexAndReset() {
        cryptexController.randomCryptex()
        updateViews()
        reset()
    }
    
/*
    private func updateTimer(timer: Timer) {
        
        if let stopDate = stopDate {
            let currentTime = Date()
            if currentTime <= stopDate {
                // Timer is active, keep counting down
               // delegate?.countdownDidUpdate(timeRemaining: timeRemaining)
               // print("Time remaining: \(timeRemaining)")
                print("hello")
                
            } else {
                // Timer is finished, reset and stop counting down
                cancelTimer()
                self.stopDate = nil
               // delegate?.countdownDidFinish()
                print("Finished")
            }
        }
 */
}
