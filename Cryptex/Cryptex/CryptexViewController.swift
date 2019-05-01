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
	
	let cryptexController = CryptexController()
	
	let letters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ").map{ String($0) }
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		unlockButton.layer.cornerRadius = 10
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		updateViews()
	}

	func updateViews() {
		hintLabel.text = cryptexController.currentCryptex?.hint
		cryptexPicker.reloadAllComponents()
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
	
	//MARK: actions
	@IBAction func unlockButtonPressed(_ sender: UIButton) {
		print(hasMatchingPassword())
	}
	
	@IBAction func newGameButtonPressed(_ sender: UIBarButtonItem) {
		
	}
	
}


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
