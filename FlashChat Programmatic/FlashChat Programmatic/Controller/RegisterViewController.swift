//
//  RegisterViewController.swift
//  FlashChat Programmatic
//
//  Created by Jeevan Chandra Joshi on 13/01/23.
//

import FirebaseAuth
import UIKit

class RegisterViewController: UIViewController {
    let emailView = UIView()
    let emailTextField = UITextField()
    let emailFieldImage = UIImageView()
    let passwordView = UIView()
    let passwordTextField = UITextField()
    let passwordFieldImage = UIImageView()
    let registerButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()
        setupConstraint()
    }

    func setupUi() {
        view.backgroundColor = UIColor(named: K.Colors.lighBlue)
        view.addSubview(emailView)
        view.addSubview(passwordView)
        view.addSubview(registerButton)

        emailView.addSubview(emailFieldImage)
        emailView.addSubview(emailTextField)

        passwordView.addSubview(passwordFieldImage)
        passwordView.addSubview(passwordTextField)

        emailTextField.textColor = UIColor(named: K.Colors.blue)
        emailTextField.font = .systemFont(ofSize: 25)
        emailTextField.textAlignment = .center
        emailTextField.placeholder = "Email"
        emailTextField.borderStyle = .none

        emailFieldImage.image = UIImage(named: "TextField")

        passwordTextField.textColor = UIColor(named: K.Colors.blue)
        passwordTextField.font = .systemFont(ofSize: 25)
        passwordTextField.textAlignment = .center
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .none
        passwordTextField.isSecureTextEntry = true

        passwordFieldImage.image = UIImage(named: "TextField")

        registerButton.setTitle("Register", for: .normal)
        registerButton.titleLabel?.font = .systemFont(ofSize: 30)
        registerButton.setTitleColor(UIColor(named: K.Colors.lighBlue), for: .normal)
        registerButton.backgroundColor = UIColor(named: K.Colors.blue)
        registerButton.addTarget(self, action: #selector(registerPressed), for: .touchUpInside)
    }

    func setupConstraint() {
        emailView.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailFieldImage.translatesAutoresizingMaskIntoConstraints = false
        passwordView.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordFieldImage.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            emailView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            emailView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            emailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            emailView.heightAnchor.constraint(equalToConstant: 150),

            emailTextField.leadingAnchor.constraint(equalTo: emailView.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: emailView.trailingAnchor),
            emailTextField.topAnchor.constraint(equalTo: emailView.topAnchor),
            emailTextField.bottomAnchor.constraint(equalTo: emailView.bottomAnchor, constant: -35),

            emailFieldImage.leadingAnchor.constraint(equalTo: emailView.leadingAnchor),
            emailFieldImage.trailingAnchor.constraint(equalTo: emailView.trailingAnchor),
            emailFieldImage.topAnchor.constraint(equalTo: emailView.topAnchor),
            emailFieldImage.bottomAnchor.constraint(equalTo: emailView.bottomAnchor),

            passwordView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            passwordView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            passwordView.topAnchor.constraint(equalTo: emailView.bottomAnchor, constant: -50),
            passwordView.heightAnchor.constraint(equalToConstant: 150),

            passwordTextField.leadingAnchor.constraint(equalTo: passwordView.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordView.trailingAnchor),
            passwordTextField.topAnchor.constraint(equalTo: passwordView.topAnchor),
            passwordTextField.bottomAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: -35),

            passwordFieldImage.leadingAnchor.constraint(equalTo: passwordView.leadingAnchor),
            passwordFieldImage.trailingAnchor.constraint(equalTo: passwordView.trailingAnchor),
            passwordFieldImage.topAnchor.constraint(equalTo: passwordView.topAnchor),
            passwordFieldImage.bottomAnchor.constraint(equalTo: passwordView.bottomAnchor),

            registerButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            registerButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            registerButton.topAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: -25),
            registerButton.heightAnchor.constraint(equalToConstant: 75),
        ])
    }

    @objc func registerPressed() {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { _, error in
                if error != nil {
                    handleError(self, error)
                    return
                }
                self.navigationController?.pushViewController(ChatViewController(), animated: true)
            }
        }
    }
}
