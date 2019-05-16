//
//  CryptexViewController.swift
//  Cryptex
//
//  Created by Nathan Hedgeman on 5/14/19.
//  Copyright © 2019 Nate Hedgeman. All rights reserved.
//

import UIKit

class CryptexViewController: UIViewController {
    
    
    //MARK: Stored Properties
    var cryptexController = CryptexController()
    
    var letters = ["A", "B", "C", "D",
                   "E", "F", "G", "H",
                   "I", "J", "K", "L",
                   "M", "N", "O", "P",
                   "Q", "R", "S", "T",
                   "U", "V", "W", "X",
                   "Y", "Z"]
    
    var countdownTimer: Timer?
    
    //MARK: Outlets
    @IBOutlet weak var Picker: UIPickerView!
    @IBOutlet weak var HintLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Picker.dataSource = self
        Picker.delegate = self
        // Do any additional setup after loading the view.
        self.Picker.becomeFirstResponder()
        self.HintLabel.becomeFirstResponder()
        updateViews()
    }
    
    //MARK: Button
    @IBAction func UnlockButton(_ sender: Any) {
        
        if hasMatchingPassword() {
            presentCorrectPasswordAlert()
        } else {
            presentIncorrectPasswordAlert()
        }
        
    }
    
}





//MARK: Picker View Handling


extension CryptexViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // For the number of components, think about how you can figure out how many characters are in the `currentCryptex`'s password.
        return cryptexController.currentCryptex?.password.count ?? 0
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // For the number of rows, we want to show as many rows as there are letters.
        return letters.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // For the title of each row, we want to show the letter that corresponds to the row. i.e. row 0 should show "A", row 1 should show "B", etc.
        return letters[row]
    }
    
    // Sets Hint Label's Text
    func updateViews() {
        HintLabel.text = cryptexController.currentCryptex?.hint
        reloadInputViews()
    }


    
    
    //MARK: Game Logic
    
    
    func hasMatchingPassword() -> Bool {
        
        var userGuess: [String] = []
        
        //This uses the .numberofComponents for the end limit of the loop. Then x returns the Letter number of the individual picker collumn. It then assigns that number as the index of the letters in the letters array index and appends that letter (based on its index place/number in the letters array) to the userGuess array that was created.
        for x in 0...(Picker!.numberOfComponents - 1) {
            userGuess.append(letters[Picker.selectedRow(inComponent: x)])
        }
        //This joins the userGuess arrays indexes into a single string, compares it to the password and returns a bool
        return userGuess.joined() == cryptexController.currentCryptex?.password
        
    }
    
    func reset() {
        
       countdownTimer?.invalidate()
        
        let newTimer = Timer.scheduledTimer(withTimeInterval: 60, repeats: false) {
            
                newTimer in print("Timer Has Finished")
            
            }
        
        countdownTimer = newTimer
        
        for x in 0...(Picker!.numberOfComponents - 1) {
            Picker.selectRow(1, inComponent: x, animated: true)
            
        }
    }
    
    func newCryptexAndReset() {
        
        cryptexController.randomCryptex()
        updateViews()
        reset()
    }
    
    
    //MARK: Alert Controls
    
    
    func presentCorrectPasswordAlert() {
        
       let correctAlert = UIAlertController(title: "Correct Answer!", message: "Great Job! Try Another One!", preferredStyle: .alert)
        
        correctAlert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { action in
            
            self.newCryptexAndReset()
            
        }))
        
        self.present(correctAlert, animated: true)
    }
    
    func presentIncorrectPasswordAlert() {
        
        let incorrectAlert = UIAlertController(title: "Sorry, wrong answer.", message: "Give it another shot!", preferredStyle: .alert)
        
        incorrectAlert.addAction(UIAlertAction(title: "Keep Trying", style: .default))
        
        incorrectAlert.addAction(UIAlertAction(title: "Next One", style: .default, handler: { action in
            
            self.newCryptexAndReset()
            
        }))
        
        self.present(incorrectAlert, animated: true)
    }
    
    func presentNoTimeRemainingAlert() {
        
        let timeRanOut = UIAlertController(title: "Time Ran Out!", message: "You've gotta be quicker than that!", preferredStyle: .alert)
        
        timeRanOut.addAction(UIAlertAction(title: "Try A New One", style: .default, handler: { action in
            
            self.newCryptexAndReset()
            
        }))
        
        timeRanOut.addAction(UIAlertAction(title: "Keep Guessing", style: .default, handler: { action in
            
            self.reset()
            
        }))
    }
    
}
