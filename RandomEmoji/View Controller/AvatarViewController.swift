//
//  AvatarViewController.swift
//  RandomEmoji
//
//  Created by Filipe Santo on 20/01/2022.
//
import UIKit

class AvatarViewController: UIViewController  {
    var coordinator: CoordinatorProtocol?
    @IBOutlet weak var avatarCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        avatarCollectionView.backgroundColor = .clear
        avatarCollectionView.delegate = self
    }
}


//MARK: - UICollectionViewDelegate

extension AvatarViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coordinator?.avatars.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath)
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.backgroundView?.largeContentImage = coordinator?.avatars[indexPath.row]
        
        
        return cell
    }
}

