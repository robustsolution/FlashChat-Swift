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

        titleLabel.text = "⚡️FlashChat"
        titleLabel.textColor = UIColor(named: "BrandBlue")
        titleLabel.font = .systemFont(ofSize: 50, weight: .heavy)
        titleLabel.textAlignment = .center

        registerButton.setTitle("Register", for: .normal)
        registerButton.titleLabel?.font = .systemFont(ofSize: 30)
        registerButton.setTitleColor(UIColor(named: "BrandBlue"), for: .normal)
        registerButton.backgroundColor = UIColor(named: "BrandLightBlue")

        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.font = .systemFont(ofSize: 30)
        loginButton.setTitleColor(UIColor(named: "BrandLightBlue"), for: .normal)
        loginButton.backgroundColor = UIColor(named: "BrandBlue")
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
