//
//  EmojiManager.swift
//  RandomEmoji
//
//  Created by Filipe Santo on 20/01/2022.
//

import Foundation
import CoreLocation
import UIKit

protocol EmojiManagerDelegate {
    func didUpdateEmojis(_ emojiManager: EmojiManager, emoji: [EmojiModel])
    func didFailWithError(error: Error)
}

//MARK: -  Data structs for the request
struct EmojisData: Codable {
    typealias emojis = [String: String]
}

//MARK: - Emoji model, conjunto dos nomes e emojis
struct EmojiModel {
    let name: String
    let emoji: UIImage
}

//MARK: - Emoji manager, para tratar do request dos apis
struct EmojiManager {
    let emojiURL = "https://api.github.com/emojis"
    
    var delegate: EmojiManagerDelegate?
    
    func fetchEmoji() {
        //(completion: @escaping ([EmojiModel] -> Void)
        performRequest(with: emojiURL)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let emoji = self.parseJSON(safeData) {
                        self.delegate?.didUpdateEmojis(self, emoji: emoji)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ emojisData: Data) -> [EmojiModel]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([String:String].self, from: emojisData)
            return try decodedData.map {
                EmojiModel(name: $0.key, emoji: try UIImage(withContentsOfUrl: URL(string: $0.value)!)!)}
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
