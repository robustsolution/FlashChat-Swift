//
//  MessageCell.swift
//  FlashChat Programmatic
//
//  Created by Jeevan Chandra Joshi on 15/01/23.
//

import UIKit

class MessageCell: UITableViewCell {
    let stackView = UIStackView()
    let messageBubble = UIView()
    let leftImageView = UIImageView()
    let label = UILabel()
    let rightImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUi()
        setupConstraint()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setupUi() {
        selectionStyle = .none
        isUserInteractionEnabled = false
        contentView.addSubview(stackView)

        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.distribution = .fill
        stackView.spacing = 20

        stackView.addArrangedSubview(leftImageView)
        stackView.addArrangedSubview(messageBubble)
        stackView.addArrangedSubview(rightImageView)

        messageBubble.addSubview(label)
        messageBubble.backgroundColor = UIColor(named: K.Colors.purple)
        messageBubble.layer.cornerRadius = frame.size.height / 5

        leftImageView.image = UIImage(named: K.youAvatar)

        label.textColor = UIColor(named: K.Colors.lightPurple)
        label.numberOfLines = 0

        rightImageView.image = UIImage(named: K.meAvatar)
    }

    func setupConstraint() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        messageBubble.translatesAutoresizingMaskIntoConstraints = false
        leftImageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        rightImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            leftImageView.heightAnchor.constraint(equalToConstant: 50),
            leftImageView.widthAnchor.constraint(equalToConstant: 50),

            label.topAnchor.constraint(equalTo: messageBubble.topAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: messageBubble.bottomAnchor, constant: -10),
            label.leadingAnchor.constraint(equalTo: messageBubble.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: messageBubble.trailingAnchor, constant: -10),

            rightImageView.heightAnchor.constraint(equalToConstant: 50),
            rightImageView.widthAnchor.constraint(equalToConstant: 50),
        ])
    }
}
