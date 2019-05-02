//
//  CryptexViewController.swift
//  Cryptex
//
//  Created by Hector Steven on 5/1/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class CryptexViewController: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCryptexAlert))
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Set Timer", style: .plain, target: self, action: #selector(setTimerAlert))
		pickerView.delegate = self
		pickerView.dataSource = self
		updateViews()
		reset()
	}
	
	func updateViews(){
		if let cryptex = cryptexController.currentCryptex {
			hintLabel?.text = cryptex.hint
			pickerView.reloadAllComponents()
		}
	}
	
	@IBAction func unlockButtonPressed(_ sender: Any) {
		hasMatchingPassword() ? presentCorrectPasswordAlert() : presentIncorrectPasswordAlert()
	}

	
	var SETTIMER: TimeInterval = 60
	var countdownTimer: Timer?
	
	@IBOutlet var hintLabel: UILabel!
	@IBOutlet var pickerView: UIPickerView!
	@IBOutlet var unlockButton: UIButton!

	let cryptexController = CryptexController()
	
	var letters = ["A", "B", "C", "D",
				   "E", "F", "G", "H",
				   "I", "J", "K", "L",
				   "M", "N", "O", "P",
				   "Q", "R", "S", "T",
				   "U", "V", "W", "X",
				   "Y", "Z"]
}

extension CryptexViewController: UIPickerViewDataSource, UIPickerViewDelegate {
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		if let cryptex = cryptexController.currentCryptex {
			return cryptex.password.count
		}
		
		return 0
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return letters.count
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		for (index, char) in letters.enumerated() {
			if index == row {
				return String(char)
			}
		}
		
		return nil
	}
}

extension CryptexViewController {
	
	func hasMatchingPassword() -> Bool {
		let checkString = constructStringFromComponents()
	
		if let cryptex = cryptexController.currentCryptex {
			if checkString.lowercased() == cryptex.password.lowercased() {
				return true
			}
		}
		
		return false
	}
	
	func constructStringFromComponents() -> String {
		let numberOfComponents = pickerView.numberOfComponents - 1
		var checkString = ""
		
		for index in 0...numberOfComponents {
			let componentValue = pickerView.selectedRow(inComponent: index)
			checkString += letters[componentValue]
		}
		
		return checkString
	}
	
	func reset() {
		countdownTimer = nil
		countdownTimer = Timer.scheduledTimer(withTimeInterval: SETTIMER, repeats: true) { timer in
			timer.invalidate()
			self.hasMatchingPassword() ? self.presentCorrectPasswordAlert() : self.presentNoTimeRemainingAlert()
		}
	}
	
	func newCryptexAndReset() {
		cryptexController.randomCryptex()
		updateViews()
		reset()
	}
	
	func setTimerFromAlert(seconds: String?) {
		guard let seconds = seconds else {
			setTimerAlert()
			return
		}
		guard let secondsInt = Int(seconds) else { return }
		
		if seconds.isEmpty || (secondsInt < 10 && secondsInt > 300) {
			setTimerAlert()
		}
		
		SETTIMER = TimeInterval(secondsInt)
	}
}
