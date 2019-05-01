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
	
	@IBOutlet var guessButton: UIButton!
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}

	@IBAction func guessButtonPressed(_ sender: UIButton) {
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
