//
//  RegisterViewController.swift
//  FlashChat Storyboard
//
//  Created by Jeevan Chandra Joshi on 13/01/23.
//

import FirebaseAuth
import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { _, error in
                if error != nil {
                    handleError(self, error)
                    return
                }
                self.performSegue(withIdentifier: K.registerSegue, sender: self)
            }
        }
    }
}
