//
//  CryptexViewController.swift
//  Cryptex
//
//  Created by Thomas Cacciatore on 5/8/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

import UIKit

class CryptexViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.dataSource = self
        pickerView.delegate = self
        updateViews()
    }
    

    func updateViews() {
        hintLabel.text = cryptexController.currentCryptex?.hint
        // reload components of the picker view
        pickerView.reloadAllComponents()
    }
    
    func reset() {
        //invalidate old timer.
        
        
        
        
        //create new timer
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { timer in self.presentNoTimeRemainingalert() }
    }
    
    func newCryptexAndReset() {
        cryptexController.randomCryptex()
        updateViews()
        reset()
    }
    
    func hasMatchingPassword() -> Bool {
        guard let currentPassword = cryptexController.currentCryptex else { return false }
        
        var letterArray: [String] = []
        //loop through picker view letters and add them to letterArray
        for i in 0..<currentPassword.password.count {
            let row = pickerView.selectedRow(inComponent: i)
            guard let title = pickerView(pickerView, titleForRow: row, forComponent: i) else { continue }
            letterArray.append(title)
        }
        //turn the array of letter into a string
        let string = letterArray.joined().uppercased()
        //compare current cryptex password to that string using uppercased
        //return a bool
        return string == currentPassword.password.uppercased()

    }
    
    func presentCorrectPasswordAlert() {
        let alert = UIAlertController(title: "Hooray!", message: "You guessed the password!", preferredStyle: .alert)
        //Directions say to change handler to newCryptexAndReset but keeps getting error
        alert.addAction(UIAlertAction(title: "Play Again", style: .default) { (_) in self.newCryptexAndReset()
        })
        present(alert, animated: true, completion: nil)
    }
    
    func presentIncorrectPasswordAlert() {
        let alert = UIAlertController(title: "Oops!", message: "Sorry that is not the correct password.", preferredStyle: .alert)
        //use reset() in handler??
        alert.addAction(UIAlertAction(title: "Reset Timer", style: .default) { (_) in
            self.reset()
        })
        //use newCryptexAndReset in handler??
        alert.addAction(UIAlertAction(title: "Try another", style: .default) { (_) in
            self.newCryptexAndReset()
        })
        present(alert, animated: true, completion: nil)
    }
    
    func presentNoTimeRemainingalert() {
        let alert = UIAlertController(title: "Time's Up!", message: "Sorry, you ran out of time", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Reset Timer", style: .default, handler: { (_) in
            self.reset()
        }))
        alert.addAction(UIAlertAction(title: "New Cryptex", style: .default, handler: { (_) in
            self.newCryptexAndReset()
        }))
        present(alert, animated: true, completion: nil)
    }



    @IBAction func unlockButtonTapped(_ sender: Any) {
        //use has matching password method to check equality. if true present correct alert. if false present incorrect alert.
        if hasMatchingPassword() == true {
            presentCorrectPasswordAlert()
        } else {
            presentIncorrectPasswordAlert()
        }
    }
    
    
    //Mark: Properties
    
    var cryptexController = CryptexController()
    
    var countdownTimer: Timer?
    
    var letters = ["A", "B", "C", "D",
                   "E", "F", "G", "H",
                   "I", "J", "K", "L",
                   "M", "N", "O", "P",
                   "Q", "R", "S", "T",
                   "U", "V", "W", "X",
                   "Y", "Z"]

    
    
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var unlockButton: UIButton!
    
    
}

extension CryptexViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        guard let componentCount = cryptexController.currentCryptex?.password.count else { return 0 }
        return componentCount
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return letters.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // For the title of each row, we want to show the letter that corresponds to the row. i.e. row 0 should show "A", row 1 should show "B", etc.
        var pickedLetter = ""
        pickedLetter = letters[row]
        
        return pickedLetter
    }

}

extension CryptexViewController: UIPickerViewDelegate {
    
}
