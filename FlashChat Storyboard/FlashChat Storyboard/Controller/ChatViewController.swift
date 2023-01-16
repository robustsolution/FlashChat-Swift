//
//  ChatViewController.swift
//  FlashChat Storyboard
//
//  Created by Jeevan Chandra Joshi on 13/01/23.
//

import FirebaseAuth
import FirebaseFirestore
import UIKit

class ChatViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var messageTextField: UITextField!

    let db = Firestore.firestore()
    var messages: [Message] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = K.title
        navigationItem.hidesBackButton = true
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.cellIdentifier, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        loadMessages()
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

    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch {
            handleError(self, error)
        }
    }

    @IBAction func sendPressed(_ sender: UIButton) {
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
