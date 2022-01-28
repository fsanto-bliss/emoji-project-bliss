//
//  EmojiFactory.swift
//  RandomEmoji
//
//  Created by Filipe Santo on 25/01/2022.
//

import Foundation
import UIKit

class EmojiFactory {
    var emojiManager:EmojiManager?
    var repositoryManager = RepositoryManager()
    var userManager = UserManager()
    
    var repo:[String]?
    var emoji:[EmojiModel]?
    var avatar:[UIImage]?
    
    public init() {
        repositoryManager.fetchRepos()
        
        self.emojiManager = EmojiManager()
        self.emojiManager?.delegate = self
        self.emojiManager?.fetchEmoji()

        repositoryManager.delegate = self
        userManager.delegate = self
    }
    
    func randomEmoji() -> UIImage? {
        guard let lenght = emoji?.count else { return nil }
        let randomIndex = Int.random(in: 0..<lenght)
        return emoji?[randomIndex].emoji
    }
    
    func setAvatar(name:String) {
        userManager.fetchAvatar(user: name)
    }
    
    func getAvatars() -> [UIImage]? {
        return avatar
    }
    
    func getEmoji() -> [UIImage]? {
        return emoji?.compactMap{$0.emoji}
    }
    
    func getRepo() -> [String] {
        return repo ?? []
    }
}

//MARK: - EmojiManagerDelegate

extension EmojiFactory: EmojiManagerDelegate {
    func didUpdateEmojis(_ emojiManager: EmojiManager, emoji: [EmojiModel]) {
        self.emoji = emoji
    }
    
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
}

//MARK: - UserManagerDelegate

extension EmojiFactory: UserManagerDelegate {
    func didUpdateUser(_ userManager: UserManager, avatar: UIImage) {
        self.avatar?.append(avatar)
    }
}

//MARK: - RepositoryManagerDelegate

extension EmojiFactory: RepositoryManagerDelegate {
    func didUpdateRepository(_ repositoryManager: RepositoryManager, repository: [String]) {
        self.repo = repository
    }
}
