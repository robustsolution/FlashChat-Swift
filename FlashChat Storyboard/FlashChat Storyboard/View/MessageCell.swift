//
//  MessageCell.swift
//  FlashChat Storyboard
//
//  Created by Jeevan Chandra Joshi on 15/01/23.
//

import UIKit

class MessageCell: UITableViewCell {
    @IBOutlet var messageBubble: UIView!
    @IBOutlet var label: UILabel!
    @IBOutlet var leftImageView: UIImageView!
    @IBOutlet var rightImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        messageBubble.layer.cornerRadius = frame.size.height / 5
    }
}
