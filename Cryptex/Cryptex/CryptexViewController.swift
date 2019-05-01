//
//  CryptexViewController.swift
//  Cryptex
//
//  Created by morse on 5/1/19.
//  Copyright © 2019 morse. All rights reserved.
//

import UIKit

class CryptexViewController: UIViewController {
    @IBOutlet var hintLabel: UILabel!
    @IBOutlet var letterPickerView: UIPickerView!
    @IBOutlet var unlockButton: UIButton!
    
    let cryptexController = CryptexController()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cryptexController.randomCryptex()
        print(cryptexController.currentCryptex?.hint)
    }
    
    @IBAction func unlockButtonTapped(_ sender: Any) {
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
