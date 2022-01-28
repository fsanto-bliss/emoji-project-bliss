//
//  Coordinator.swift
//  RandomEmoji
//
//  Created by Filipe Santo on 20/01/2022.
//

import Foundation
import UIKit


class Coordinator: CoordinatorProtocol {
    let emojiFactory = EmojiFactory()
    
    var delegate: CoordinatorDelegate?
    var navigationController: UINavigationController
    
    var avatars: [UIImage] {
       emojiFactory.getAvatars() ?? []
    }
    
    var emojis: [UIImage] {
        emojiFactory.getEmoji() ?? []
     }
    
    var repo: [String] {
        emojiFactory.getRepo()
     }

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
    }
    
    func start() {
        let vc = LandingViewController(nibName: "LandingVC", bundle: nil)
        vc.coordinator = self
        delegate = vc
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
        navigationController.pushViewController(vc, animated: true)
        vc.coordinator = self
    }
    
    func goToAvatar() {
        let vc = AvatarViewController(nibName: "AvatarVC", bundle: nil)
        navigationController.pushViewController(vc, animated: true)
        vc.coordinator = self
    }
    
    func goToEmoji() {
        let vc = EmojiViewController(nibName: "EmojiVC", bundle: nil)
        navigationController.pushViewController(vc, animated: true)
        vc.coordinator = self
        vc.emojiCollectionView.reloadData()
    }
    
    
}
