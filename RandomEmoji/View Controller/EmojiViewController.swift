//
//  EmojiViewController.swift
//  RandomEmoji
//
//  Created by Filipe Santo on 20/01/2022.
//

import UIKit

class EmojiViewController: UIViewController  {
    var coordinator: CoordinatorProtocol?

    @IBOutlet weak var emojiCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emojiCollectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        emojiCollectionView.delegate = self
        emojiCollectionView.dataSource = self
    }
}

//MARK: - UICollectionViewDelegate

extension EmojiViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //print(coordinator?.emojis?.count)
        return coordinator?.emojis?.count ?? 0
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.imageview.image = coordinator?.emojis?[indexPath.row]
        return cell
    }

}
