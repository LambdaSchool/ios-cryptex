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
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		unlockButton.layer.cornerRadius = 10
	}

	@IBAction func unlockButtonPressed(_ sender: UIButton) {
	}
	
}


extension CryptexViewController: UIPickerViewDelegate, UIPickerViewDataSource {
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 0
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return 0
	}
	
	
}
