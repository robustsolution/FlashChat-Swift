//
//  Utils.swift
//  FlashChat Programmatic
//
//  Created by Jeevan Chandra Joshi on 15/01/23.
//

import UIKit

struct K {
    static let title = "⚡️FlashChat"
    static let cellIdentifier = "MessageCell"
    static let meAvatar = "MeAvatar"
    static let youAvatar = "YouAvatar"

    struct Colors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }

    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}

func handleError(_ self: UIViewController, _ error: Error?) {
    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default)
    alert.addAction(action)
    self.present(alert, animated: true)
}
