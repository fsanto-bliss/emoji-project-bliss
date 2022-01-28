//
//  ViewController.swift
//  RandomEmoji
//
//  Created by Filipe Santo on 20/01/2022.
//

import UIKit

class LandingViewController: UIViewController {
    var coordinator: CoordinatorProtocol?
    
    @IBOutlet weak var randomEmojiImage: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        textField.delegate = self
    }

    @IBAction func randomEmojiButtonPressed(_ sender: Any) {
        guard let emoji = coordinator?.randomEmoji() else { return }
        randomEmojiImage.image = emoji
    }
    
    @IBAction func emojiListButtonPressed(_ sender: Any) {
        coordinator?.goToEmoji()
    }
    
    @IBAction func avatarListButtonPressed(_ sender: Any) {
        coordinator?.goToAvatar()
    }
    
    @IBAction func appleRepoPressed(_ sender: Any) {
        coordinator?.goToRepository()
    }
    
    @IBAction func textField(_ sender: Any) {
        textField.endEditing(true)
    }
}

//MARK: - UITextFieldDelegate
extension LandingViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        textField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let name = textField.text {
            coordinator?.setAvatar(name: name)
        }
        textField.text = ""
    }
}

