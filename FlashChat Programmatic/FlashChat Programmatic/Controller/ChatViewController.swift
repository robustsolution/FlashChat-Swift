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
    let tableViewCell = MessageCell()
    let messageTextField = UITextField()
    let sendButton = UIButton()
    let logoutButton = UIBarButtonItem()

    var messages = [
        Message(sender: "Me", body: "Hey"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()
        setupConstraint()
        tableView.dataSource = self
    }

    func setupUi() {
        view.backgroundColor = UIColor(named: K.Colors.purple)
        view.addSubview(tableView)
        view.addSubview(messageView)

        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = logoutButton

        messageView.backgroundColor = UIColor(named: K.Colors.purple)
        tableView.register(MessageCell.self, forCellReuseIdentifier: K.cellIdentifier)
        messageView.addSubview(messageTextField)
        messageView.addSubview(sendButton)

        tableView.separatorStyle = .none
        tableViewCell.selectionStyle = .none

        messageTextField.textColor = UIColor(named: K.Colors.purple)
        messageTextField.font = .systemFont(ofSize: 16)
        messageTextField.placeholder = "Write a message..."
        messageTextField.borderStyle = .roundedRect

        sendButton.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        sendButton.tintColor = UIColor(named: K.Colors.lighBlue)

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
            handleError(self, error)
        }
    }
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = messages[indexPath.row].body
        return cell
    }
}
