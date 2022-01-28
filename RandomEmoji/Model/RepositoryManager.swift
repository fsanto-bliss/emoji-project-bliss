//
//  Repository.swift
//
//
//  Created by Filipe Santo on 20/01/2022.
//

import Foundation
import CoreLocation
import UIKit

protocol RepositoryManagerDelegate {
    func didUpdateRepository(_ repositoryManager: RepositoryManager, repository: [String])
    
    func didFailWithError(error: Error)
}

//MARK: -  Data structs for the request
struct RepositoriesData: Codable {
    let repositories: [RepositoryData]
}

struct RepositoryData:Codable {
    let full_name: String
}

//MARK: - Repository model, conjunto de nomes dos repositorios
struct RepositoryModel {
    let name: String
}

//MARK: - Repository manager, para tratar do request dos apis
struct RepositoryManager {
    let userURL = "https://api.github.com/users/apple/repos"
    
    var delegate: RepositoryManagerDelegate?
    
    func fetchRepos() {
        performRequest(with: userURL)
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
                    if let repos = self.parseJSON(safeData) {
                        self.delegate?.didUpdateRepository(self, repository: repos)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ repositoriesData: Data) -> [String]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(RepositoriesData.self, from: repositoriesData)
            let repoArray: [String] = decodedData.repositories.compactMap {
                return $0.full_name
            }
            
            return repoArray
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
