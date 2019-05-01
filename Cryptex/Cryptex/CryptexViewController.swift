//
//  CryptexViewController.swift
//  Cryptex
//
//  Created by Michael Redig on 5/1/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import UIKit

class CryptexViewController: UIViewController {
	
	@IBOutlet var hintLabel: UILabel!
	@IBOutlet var cryptexPicker: UIPickerView!
	@IBOutlet var unlockButton: UIButton!
	@IBOutlet var timeSlider: UISlider!
	
	let cryptexController = CryptexController()
	
	let letters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ").map{ String($0) }
	
	var countdownTimer: Timer?
	var finishTime: TimeInterval?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		unlockButton.layer.cornerRadius = 10
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		updateViews()
		newCryptexAndReset()
	}

	func updateViews() {
		hintLabel.text = cryptexController.currentCryptex?.hint
		cryptexPicker.reloadAllComponents()
		guard let dataSource = cryptexPicker.dataSource else { return }
		let lettersCount = dataSource.numberOfComponents(in: cryptexPicker)
		for component in 0..<lettersCount {
			cryptexPicker.selectRow(0, inComponent: component, animated: true)
		}
	}
	
	//MARK:- Game logic
	
	func hasMatchingPassword() -> Bool {
		guard let dataSource = cryptexPicker.dataSource, let delegate = cryptexPicker.delegate else { return false }
		let lettersCount = dataSource.numberOfComponents(in: cryptexPicker)
		var word = ""
		for index in 0..<lettersCount {
			let selectedRow = cryptexPicker.selectedRow(inComponent: index)
			if let letter = delegate.pickerView?(cryptexPicker, titleForRow: selectedRow, forComponent: index) {
				word += letter
			}
		}
		
		return word.lowercased() == cryptexController.currentCryptex?.password.lowercased()
	}
	
	
	func newCryptexAndReset() {
		reset()
		cryptexController.randomizeCryptex()
		setTimer()
		updateViews()
	}
	
	func setTimer() {
		let totalTime = cryptexController.currentCryptex?.time ?? fallbackDefaultTime
		finishTime = CFAbsoluteTimeGetCurrent() + totalTime
		timeSlider.maximumValue = Float(totalTime)
		timeSlider.minimumValue = 0
		timeSlider.value = Float(totalTime)

		countdownTimer = Timer.scheduledTimer(withTimeInterval: 1/60, repeats: true, block: { [weak self] (timer) in
			self?.checkTimeRemaining()
		})
	}
	
	let fallbackDefaultTime: TimeInterval = 60
	func reset() {
		countdownTimer?.invalidate()
		updateViews()
	}
	
	func checkTimeRemaining() {
		guard let finishTime = finishTime else { return }
		let current = CFAbsoluteTimeGetCurrent()
		let remaining = finishTime - current
		timeSlider.value = Float(remaining)
		
		if remaining <= 0 {
			reset()
			presentNoTimeRemainingAlert()
		}
	}
	
	func presentCorrectPasswordAlert() {
		let ac = UIAlertController(title: "Woot", message: "You've guessed the password!", preferredStyle: .alert)
		ac.addAction(UIAlertAction(title: "Nice", style: .default, handler: { [weak self] (action) in
			self?.newCryptexAndReset()
		}))
		present(ac, animated: true)
	}
	
	func presentIncorrectPasswordAlert() {
		let ac = UIAlertController(title: "Ugh", message: "You're wrong!", preferredStyle: .alert)
		ac.addAction(UIAlertAction(title: "Keep Trying", style: .default, handler: nil))
		ac.addAction(UIAlertAction(title: "Try a Different Cryptex", style: .default, handler: { [weak self] (action) in
			self?.newCryptexAndReset()
		}))
		present(ac, animated: true)

	}
	
	func presentNoTimeRemainingAlert() {
		let ac = UIAlertController(title: "Drat!", message: "You've run out of time!", preferredStyle: .alert)
		ac.addAction(UIAlertAction(title: "I want to cheat.", style: .default) { [weak self] alert in
			self?.setTimer()
		})
		ac.addAction(UIAlertAction(title: "Try a Different Cryptex", style: .default){ [weak self] (action) in
			self?.newCryptexAndReset()
		})
		present(ac, animated: true)
	}
	
	//MARK: - actions
	@IBAction func unlockButtonPressed(_ sender: UIButton) {
		if hasMatchingPassword() {
			reset()
			presentCorrectPasswordAlert()
		} else {
			presentIncorrectPasswordAlert()
		}
	}
	
	@IBAction func newGameButtonPressed(_ sender: UIBarButtonItem) {
		newCryptexAndReset()
	}
	
	//MARK: - nav
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let dest = segue.destination as? CryptexCreatorViewController {
			dest.cryptexController = cryptexController
			dest.validCharacters = letters
		}
	}
}


//MARK: - picker view stuff
extension CryptexViewController: UIPickerViewDelegate, UIPickerViewDataSource {
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return cryptexController.currentCryptex?.password.count ?? 0
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return letters.count
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return letters[row]
	}
	
}
