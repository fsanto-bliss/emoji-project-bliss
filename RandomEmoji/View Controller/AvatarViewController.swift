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
        avatarCollectionView.isPagingEnabled = true;
        let myCell = avatarCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! CollectionViewCell
        return myCell
    }
}

