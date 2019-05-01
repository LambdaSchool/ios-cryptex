//
//  CryptexCreatorViewController.swift
//  Cryptex
//
//  Created by Michael Redig on 5/1/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import UIKit

class CryptexCreatorViewController: UIViewController {
	@IBOutlet var hintTextField: UITextField!
	@IBOutlet var passwordTextField: UITextField!
	@IBOutlet var secondsTextField: UITextField!
	
	
	var cryptexController: CryptexController?
	var validCharacters: [String]?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
	
	func validatePassword(password: String) -> Bool {
		guard let validCharacters = validCharacters else { return false }
		let validString = String(validCharacters.compactMap{ Character($0) }).lowercased()
		let validSet = CharacterSet(charactersIn: validString)
		
		return password.lowercased().rangeOfCharacter(from: validSet.inverted, options: [], range: nil) == nil
	}
	
	@IBAction func addNewButtonPressed(_ sender: UIBarButtonItem) {
		print("pressed")
		guard let hint = hintTextField.text, let password = passwordTextField.text, let secondsStr = secondsTextField.text else {
			print("failed getting text")
			return
		}
		guard validatePassword(password: password) else {
			print("password validation failed")
			return
		}
		guard let seconds = TimeInterval(secondsStr) else {
			print("failed converting seconds")
			return
		}
		
		cryptexController?.createCryptex(hint: hint, password: password, time: seconds)
		navigationController?.popViewController(animated: true)
		
	}
}
