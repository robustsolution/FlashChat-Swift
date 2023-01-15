//
//  WelcomeViewController.swift
//  FlashChat Storyboard
//
//  Created by Jeevan Chandra Joshi on 13/01/23.
//

import UIKit

class WelcomeViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        let titleText = K.title
        titleLabel.text = ""
        for (index, letter) in titleText.enumerated() {
            Timer.scheduledTimer(withTimeInterval: 0.1 * Double(index), repeats: false) { _ in
                self.titleLabel.text?.append(letter)
            }
        }
    }
}
