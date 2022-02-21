//
//  Coordinator.swift
//  RandomEmoji
//
//  Created by Filipe Santo on 20/01/2022.
//

import Foundation
import UIKit


class Coordinator: CoordinatorProtocol {
    let emojiFactory: EmojiFactory
    
    var emojis: [UIImage]? {
        emojiFactory.getEmoji()
    }
    
    var delegate: CoordinatorDelegate?
    var navigationController: UINavigationController
    
    var avatars: [UIImage] {
       emojiFactory.getAvatars() ?? []
    }
    
    var repo: [String] {
        emojiFactory.getRepo()
     }

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        emojiFactory = EmojiFactory()
        

        
    }
    
    func start() {
        let vc = LandingViewController(nibName: "LandingVC", bundle: nil)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }

    func randomEmoji() -> UIImage? {
        return emojiFactory.randomEmoji()
    }
    
    func setAvatar(name: String) {
        emojiFactory.setAvatar(name: name)
    }
    
    func goToRepository() {
        let vc = RepositoriesViewController(nibName: "RepositoryVC", bundle: nil)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToAvatar() {
        let vc = AvatarViewController(nibName: "AvatarVC", bundle: nil)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToEmoji() {
        let vc = EmojiViewController(nibName: "EmojiVC", bundle: nil)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
