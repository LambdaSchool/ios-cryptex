//
//  CryptexViewController.swift
//  cryptex
//
//  Created by Michael Flowers on 5/1/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

class CryptexViewController: UIViewController {
    
    let cc = CryptexController()
    var letters = ["A", "B", "C", "D",
                   "E", "F", "G", "H",
                   "I", "J", "K", "L",
                   "M", "N", "O", "P",
                   "Q", "R", "S", "T",
                   "U", "V", "W", "X",
                   "Y", "Z"]
    
    var countdownTimer: Timer?
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var buttonProperties: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        updateViews()
    }
    
    @IBAction func unlockButton(_ sender: UIButton) {
        if hasMatchingPassword() {
            print("success")
            presentCorrrectPasswordAlert()
        } else {
            print("you are a failure.")
            presentIncorrectPassword()
        }
    }
    
    func updateViews(){
        pickerView.reloadAllComponents() //if we don't do this, when a new random cyrptex is started, the picker view won't update to show the (potential) new numbers of components
        label.text = cc.currentCryptex?.hint
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pickerView.reloadAllComponents()
    }
    
    func hasMatchingPassword() -> Bool {
        //get the title of each row
        guard let currentPassword = cc.currentCryptex else  { print("problem here") ; return false }
        print("this is the number of the password: \(currentPassword.password.count)")
        
        var letterInPickerView = [String]() // letterInPickerView: [String] = []
        
        for num in 0..<currentPassword.password.count {
            
            let rowIndex = pickerView.selectedRow(inComponent: num)
            
            guard let title = pickerView(pickerView, titleForRow: rowIndex, forComponent: num) else { continue }
            letterInPickerView.append(title)
        }
        
        let combinedArray = letterInPickerView.joined().lowercased()
        
        print(combinedArray == currentPassword.password.lowercased())
        return combinedArray == currentPassword.password.lowercased()
    }
    
    //MARK: - TIMER METHODS
    func reset(){
        countdownTimer?.invalidate()
        
        let newTimer = Timer.scheduledTimer(withTimeInterval: 60.0, repeats: false) { (_) in
            self.presentNoTimeRemainingAlert()
        }
        countdownTimer = newTimer
    }
    
    func newCryptextAndReset(){
        cc.randomCryptex()
        updateViews()
        reset()
    }
    
    //MARK: - ALERTCONTROLLER
    func presentCorrrectPasswordAlert(){
                let alert = UIAlertController(title: "Awesome Job", message: "You have correctly guess the right password.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Attempt another Cryptex", style: .default, handler: { (_) in
            self.newCryptextAndReset()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func presentIncorrectPassword(){
        let alert = UIAlertController(title: "Wrong", message: "you didn't guess the right password, sucka.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try agan?", style: .default, handler: nil))
        
        alert.addAction(UIAlertAction(title: "New Cryptex?", style: .default, handler: { (_) in
            self.newCryptextAndReset()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    
    func presentNoTimeRemainingAlert(){
        let alert = UIAlertController(title: "Times Up", message: "You have run out of time to complete the challenge.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Reset the timer and try again?", style: .default, handler: { (_) in
            self.reset()
        }))
        alert.addAction(UIAlertAction(title: "Try new cryptex challenge?", style: .default, handler: { (_) in
            self.newCryptextAndReset()
        }))
        present(alert, animated: true, completion: nil)
    }
}

//MARK: - PICKER VIEW DATA SOURCE AND DELEGATE
extension CryptexViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        //this sets how many columns or how wide the pickerview is, think width
        return cc.currentCryptex?.password.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //this sets up how many choices are in each column so think the height part of the pickerview
        return letters.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let letter = letters[row]
        return letter
    }
}
