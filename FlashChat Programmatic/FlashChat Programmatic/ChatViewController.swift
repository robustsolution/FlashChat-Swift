//
//  ChatViewController.swift
//  FlashChat Programmatic
//
//  Created by Jeevan Chandra Joshi on 13/01/23.
//

import FirebaseAuth
import UIKit

class ChatViewController: UIViewController {
    let tableView = UITableView()
    let messageView = UITextField()
    let tableViewCell = UITableViewCell()
    let messageTextField = UITextField()
    let sendButton = UIButton()
    let logoutButton = UIBarButtonItem()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()
        setupConstraint()
    }

    func setupUi() {
        view.backgroundColor = UIColor(named: "BrandPurple")
        view.addSubview(tableView)
        view.addSubview(messageView)

        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = logoutButton

        messageView.backgroundColor = UIColor(named: "BrandPurple")
        tableView.addSubview(tableViewCell)
        messageView.addSubview(messageTextField)
        messageView.addSubview(sendButton)

        messageTextField.textColor = UIColor(named: "BrandPurple")
        messageTextField.font = .systemFont(ofSize: 16)
        messageTextField.placeholder = "Write a message..."
        messageTextField.borderStyle = .roundedRect

        sendButton.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        sendButton.tintColor = UIColor(named: "BrandLightBlue")

        logoutButton.title = "Logout"
        logoutButton.target = self
        logoutButton.action = #selector(logoutPressed)
    }

    func setupConstraint() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        messageView.translatesAutoresizingMaskIntoConstraints = false
        messageTextField.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: messageView.topAnchor),

            messageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            messageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            messageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            messageView.heightAnchor.constraint(equalToConstant: 80),

            messageTextField.leadingAnchor.constraint(equalTo: messageView.leadingAnchor, constant: 20),
            messageTextField.topAnchor.constraint(equalTo: messageView.topAnchor, constant: 20),
            messageTextField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor),
            messageTextField.heightAnchor.constraint(equalToConstant: 50),

            sendButton.topAnchor.constraint(equalTo: messageView.topAnchor, constant: 20),
            sendButton.trailingAnchor.constraint(equalTo: messageView.trailingAnchor),
            sendButton.heightAnchor.constraint(equalToConstant: 50),
            sendButton.widthAnchor.constraint(equalToConstant: 50),
        ])
    }

    @objc func logoutPressed() {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch {
            handleError(error)
        }
    }

    func handleError(_ error: Error?) {
        let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
