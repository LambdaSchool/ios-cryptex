//
//  CryptextViewController+exntendAlerts.swift
//  Cryptex
//
//  Created by Hector Steven on 5/1/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit


extension CryptexViewController {
	
	func presentCorrectPasswordAlert() {
		guard let cryptex = cryptexController.currentCryptex else { return }
		
		let ac = UIAlertController(title: "UNLOCKED", message: "password: \(cryptex.password)", preferredStyle: .alert)
		ac.addAction(UIAlertAction(title: "PLAY AGAIN", style: .cancel){ action in
			self.newCryptexAndReset()
		})
		
		self.present(ac, animated: true)
	}
	
	func presentIncorrectPasswordAlert() {
		let ac = UIAlertController(title: "INVALID", message: nil, preferredStyle: .alert)
		
		ac.addAction(UIAlertAction(title: "PLAY AGAIN", style: .default){ action in
			self.newCryptexAndReset()
		})
		
		present(ac, animated: true)
	}
	
	func presentNoTimeRemainingAlert() {
		let ac = UIAlertController(title: "Time  Ran Out!", message: "You ran out of time to guess the password.", preferredStyle: .alert)
		
		ac.addAction(UIAlertAction(title: "Retry cryptex", style: .cancel) { action in
			self.reset()
		})
		
		ac.addAction(UIAlertAction(title: "New Cryptex", style: .default) { action in
			self.newCryptexAndReset()
		})
		
		present(ac, animated: true)
	}
	
	@objc func addCryptexAlert() {
		countdownTimer = nil
		
		let ac = UIAlertController(title: "Create Cryptex", message: "Add password and a hint", preferredStyle: .alert)
		
		ac.addTextField()
		ac.addTextField()
		
		ac.addAction(UIAlertAction(title: "ADD", style: .default){ action in
			//create action
			let password = ac.textFields?[0].text
			let hint = ac.textFields?[1].text
			self.addNewCryptex(password: password!, hint: hint!)
			
		})
		
		ac.addAction(UIAlertAction(title: "Canel", style: .cancel))
		
		present(ac, animated: true)
	}
	
	func addNewCryptex(password: String?, hint: String?) {
		guard let password = password,
			let hint = hint,
			password.count <= 7,
			!password.isEmpty, !hint.isEmpty else {
				addCryptexAlert()
				return
		}
		
		cryptexController.createCryptex(password: password, hint: hint)
		newCryptexAndReset()
	}
	
	@objc func setTimerAlert() {
		let ac = UIAlertController(title: "Set Timer", message: "(from 10 - 300)timer in seconds:", preferredStyle: .alert)
		
		ac.addTextField()
		
		ac.addAction(UIAlertAction(title: "Set", style: .default){
			action in
			//send to function
			let seconds = ac.textFields?[0].text
			self.setTimerFromAlert(seconds: seconds)
		})
		
		ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
		
		present(ac, animated: true)
	}
}
