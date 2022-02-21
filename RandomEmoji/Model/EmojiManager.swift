//
//  EmojiManager.swift
//  RandomEmoji
//
//  Created by Filipe Santo on 20/01/2022.
//

import Foundation
import CoreLocation
import UIKit

//MARK: - EmojiModel
struct Emoji {
    var name: String
    var url: String
}

//MARK: - EmojiFetcher
class EmojisService {
    
    // request the emojis list
    func fetchEmojis(completion: @escaping ([Emoji]) -> Void) {
        let url = URL(string: "https://api.github.com/emojis")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            let decoded = try! JSONDecoder().decode([String: String].self, from: data)
            let emojis = decoded.map { Emoji(name: $0.key, url: $0.value)}
            completion(emojis)
        }
        
        task.resume()
    }
}
