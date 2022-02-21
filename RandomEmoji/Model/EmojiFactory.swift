//
//  EmojiFactory.swift
//  RandomEmoji
//
//  Created by Filipe Santo on 25/01/2022.
//

import Foundation
import UIKit

class EmojiFactory {
    var emojis: [Emoji] = []
    
    var emojiManager:EmojisService?
    var repositoryManager:RepositoryManager?
    var userManager:UserManager?
    
    var repo:[String]?
    var avatar:[UIImage]?
    
    public init() {
        
    }
    
    func randomEmoji() -> UIImage? {
        let randomIndex = Int.random(in: 0..<emojis.count)
        guard let image = try? UIImage(withContentsOfUrl: URL(string: emojis[randomIndex].url)!) else { return nil }
        return image
    }
    
    func setAvatar(name:String) {
        userManager?.fetchAvatar(user: name)
    }
    
    func getAvatars() -> [UIImage]? {
        return avatar
    }
    
    func getEmoji() -> [UIImage]? {
        return emojis.compactMap{
            try? UIImage(withContentsOfUrl: URL(string: $0.url)!)
        }
    }
    
    func getRepo() -> [String] {
        return repo ?? []
    }
}

//MARK: - UserManagerDelegate

extension EmojiFactory: UserManagerDelegate {
    func didUpdateUser(_ userManager: UserManager, avatar: UIImage) {
        self.avatar?.append(avatar)
        //reload data
    }
    
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
}

//MARK: - RepositoryManagerDelegate

extension EmojiFactory: RepositoryManagerDelegate {
    func didUpdateRepository(_ repositoryManager: RepositoryManager, repository: [String]) {
        self.repo = repository
        //reload data
    }
}
