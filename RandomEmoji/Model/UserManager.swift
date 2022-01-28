//
//  UserManager.swift
//  RandomEmoji
//
//  Created by Filipe Santo on 20/01/2022.
//


import Foundation
import CoreLocation
import UIKit



protocol UserManagerDelegate {
    func didUpdateUser(_ userManager: UserManager, avatar: UIImage)
    func didFailWithError(error: Error)
}

//MARK: - Data structs para o Request
struct UserData:Decodable {
    let avatar_url: String
}

//MARK: - User manager, para tratar dos requests dos apis
struct UserManager {
    let userURL = "https://api.github.com/users/"
    
    var delegate: UserManagerDelegate?
    
    func fetchAvatar(user: String) {
        let url = userURL + user
        performRequest(with: url)
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
                    if let avatar = self.parseJSON(safeData) {
                        self.delegate?.didUpdateUser(self, avatar: avatar)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ userData: Data) -> UIImage? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(UserData.self, from: userData)
            
            let urlImage = decodedData.avatar_url
            let avatar = try? UIImage(withContentsOfUrl: URL(string: urlImage)!)
            
            return avatar
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
