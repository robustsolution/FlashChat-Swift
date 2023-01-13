//
//  ChatViewController.swift
//  FlashChat Programmatic
//
//  Created by Jeevan Chandra Joshi on 13/01/23.
//

import UIKit

class ChatViewController: UIViewController {
    let tableView = UITableView()
    let messageView = UITextField()
    let tableViewCell = UITableViewCell()
    let messageTextField = UITextField()
    let sendButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()
        setupConstraint()
    }

    func setupUi() {
        view.backgroundColor = UIColor(named: "BrandPurple")
        view.addSubview(tableView)
        view.addSubview(messageView)

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
}
