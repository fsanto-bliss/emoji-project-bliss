//
//  Repository.swift
//
//
//  Created by Filipe Santo on 20/01/2022.
//

import Foundation
import CoreLocation
import UIKit

//MARK: - RepositoryData
struct Repository: Decodable, Equatable {
    let fullName : String
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
    }
}

//MARK: - RepositoryService
class RepositoryService {
    
    // request the repository list
    func fetchRepository(perPage: Int,page: Int, completion: @escaping ([Repository]) -> Void) {
        let url = URL(string: "https://api.github.com/users/apple/repos?per_page=\(perPage)&page=\(page)")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            let decoded = try! JSONDecoder().decode([Repository].self, from: data)
            completion(decoded)
        }
        task.resume()
    }
}
