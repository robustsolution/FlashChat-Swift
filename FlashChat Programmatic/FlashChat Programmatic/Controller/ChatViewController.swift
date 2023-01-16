//
//  ChatViewController.swift
//  FlashChat Programmatic
//
//  Created by Jeevan Chandra Joshi on 13/01/23.
//

import FirebaseAuth
import FirebaseFirestore
import UIKit

class ChatViewController: UIViewController {
    let tableView = UITableView()
    let messageView = UITextField()
    let tableViewCell = MessageCell()
    let messageTextField = UITextField()
    let sendButton = UIButton()
    let logoutButton = UIBarButtonItem()

    let db = Firestore.firestore()
    var messages: [Message] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()
        setupConstraint()
        loadMessages()
    }

    func setupUi() {
        title = K.title
        view.backgroundColor = UIColor(named: K.Colors.purple)
        view.addSubview(tableView)
        view.addSubview(messageView)

        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = logoutButton

        messageView.backgroundColor = UIColor(named: K.Colors.purple)
        messageView.addSubview(messageTextField)
        messageView.addSubview(sendButton)

        tableView.dataSource = self
        tableView.register(MessageCell.self, forCellReuseIdentifier: K.cellIdentifier)
        tableView.separatorStyle = .none
        tableViewCell.selectionStyle = .none

        messageTextField.textColor = UIColor(named: K.Colors.purple)
        messageTextField.font = .systemFont(ofSize: 16)
        messageTextField.placeholder = "Write a message..."
        messageTextField.borderStyle = .roundedRect

        sendButton.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        sendButton.tintColor = UIColor(named: K.Colors.lighBlue)
        sendButton.addTarget(self, action: #selector(sendPressed), for: .touchUpInside)

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

    func loadMessages() {
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { querySnapshot, error in
                if error != nil {
                    handleError(self, error)
                } else {
                    self.messages = []
                    if let snapshot = querySnapshot?.documents {
                        for doc in snapshot {
                            let message = doc.data()
                            if let sender = message[K.FStore.senderField] as? String, let body = message[K.FStore.bodyField] as? String {
                                self.messages.append(Message(sender: sender, body: body))
                                DispatchQueue.main.async { [self] in
                                    tableView.reloadData()
                                    let indexPath = IndexPath(row: messages.count - 1, section: 0)
                                    tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                                }
                            }
                        }
                    }
                }
            }
    }

    @objc func logoutPressed() {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch {
            handleError(self, error)
        }
    }

    @objc func sendPressed() {
        if let body = messageTextField.text, let sender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: sender,
                K.FStore.bodyField: body,
                K.FStore.dateField: Date().timeIntervalSince1970,
            ]) { error in
                if error != nil {
                    handleError(self, error)
                } else {
                    DispatchQueue.main.async {
                        self.messageTextField.text = ""
                    }
                }
            }
        }
    }
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        let message = messages[indexPath.row]
        cell.label.text = message.body
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.Colors.lightPurple)
            cell.label.textColor = UIColor(named: K.Colors.purple)
        } else {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: K.Colors.purple)
            cell.label.textColor = UIColor(named: K.Colors.lightPurple)
        }
        return cell
    }
}
