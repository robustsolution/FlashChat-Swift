//
//  WelcomeViewController.swift
//  FlashChat Programmatic
//
//  Created by Jeevan Chandra Joshi on 13/01/23.
//

import UIKit

class WelcomeViewController: UIViewController {
    let titleLabel = UILabel()
    let registerButton = UIButton()
    let loginButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()
        setupConstraint()
    }

    func setupUi() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(registerButton)
        view.addSubview(loginButton)

        let titleText = "⚡️FlashChat"
        titleLabel.text = ""
        titleLabel.textColor = UIColor(named: "BrandBlue")
        titleLabel.font = .systemFont(ofSize: 50, weight: .heavy)
        titleLabel.textAlignment = .center
        for (index, letter) in titleText.enumerated() {
            Timer.scheduledTimer(withTimeInterval: 0.1 * Double(index), repeats: false) { _ in
                self.titleLabel.text?.append(letter)
            }
        }

        registerButton.setTitle("Register", for: .normal)
        registerButton.titleLabel?.font = .systemFont(ofSize: 30)
        registerButton.setTitleColor(UIColor(named: "BrandBlue"), for: .normal)
        registerButton.backgroundColor = UIColor(named: "BrandLightBlue")
        registerButton.addAction(UIAction(handler: { _ in
            self.navigationController?.pushViewController(RegisterViewController(), animated: true)
        }), for: .touchUpInside)

        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.font = .systemFont(ofSize: 30)
        loginButton.setTitleColor(UIColor(named: "BrandLightBlue"), for: .normal)
        loginButton.backgroundColor = UIColor(named: "BrandBlue")
        loginButton.addAction(UIAction(handler: { _ in
            self.navigationController?.pushViewController(LoginViewController(), animated: true)
        }), for: .touchUpInside)
    }

    func setupConstraint() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            registerButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            registerButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            registerButton.bottomAnchor.constraint(equalTo: loginButton.topAnchor),
            registerButton.heightAnchor.constraint(equalToConstant: 75),

            loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 75),
        ])
    }
}
