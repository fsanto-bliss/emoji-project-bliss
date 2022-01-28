//
//  RepositoriesViewController.swift
//  RandomEmoji
//
//  Created by Filipe Santo on 20/01/2022.
//

import UIKit

class RepositoriesViewController: UIViewController {
    var coordinator: CoordinatorProtocol?

    @IBOutlet weak var repositoriesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        repositoriesTableView.backgroundColor = .clear
        repositoriesTableView.delegate = self
    }
    
    
}

//MARK: - UITableViewDelegate
extension RepositoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coordinator?.repo.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Reuse or create a cell.
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // For a standard cell, use the UITableViewCell properties.
        cell.textLabel!.text = coordinator?.repo[indexPath.row]
        return cell
    }
}
