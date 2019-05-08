//
//  AddCryptexViewController.swift
//  Cryptex
//
//  Created by Jonathan Ferrer on 5/8/19.
//  Copyright © 2019 Jonathan Ferrer. All rights reserved.
//

import UIKit

class AddCryptexViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   

    //MARK: - Methods
    @IBAction func addCryptexButtonPressed(_ sender: Any) {
        guard let password = passwordTextField.text?.uppercased(), !password.isEmpty,
            let hint = hintTextField.text, !hint.isEmpty else { return }
        cryptexController.cryptexes.append(Cryptex(password: password, hint: hint))
        print(cryptexController.cryptexes)
        self.dismiss(animated: true) {
        }
    }



    //MARK: - Properties
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var hintTextField: UITextField!
    var cryptexController = CryptexController()

}
