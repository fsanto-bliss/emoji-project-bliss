//
//  RepositoriesViewController.swift
//  RandomEmoji
//
//  Created by Filipe Santo on 20/01/2022.
//

import UIKit

class RepositoriesViewController: UIViewController {
    let PER_PAGE_VALUE = 20
    let repoService = RepositoryService()
    var currentCount = 1
    
    var coordinator: CoordinatorProtocol?
    @IBOutlet weak var repositoriesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        repositoriesTableView.delegate = self
        repositoriesTableView.dataSource = self

        repositoriesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchRepos()
    }
    
    func fetchRepos() {
        repoService.fetchRepository(perPage: PER_PAGE_VALUE, page: currentCount, completion: { repositories in
            if repositories != [] {
                DispatchQueue.main.async {
                    if self.currentCount>1 {
                        self.coordinator?.repo.append(contentsOf: repositories.compactMap { $0.fullName })
                    } else {
                        self.coordinator?.repo = repositories.compactMap { $0.fullName }
                    }
                    self.repositoriesTableView.reloadData()
                    self.currentCount+=1
                }
            }
        })
    }
}

//MARK: - UITableViewDelegate
extension RepositoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coordinator?.repo.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = repositoriesTableView.dequeueReusableCell(withIdentifier: "cell",
                 for: indexPath)
        cell.textLabel!.text = coordinator?.repo[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        guard let count = coordinator?.repo.count else { return }
        if indexPath.row == (count - 1)
        {
            fetchRepos()
        }
    }
}

