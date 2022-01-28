//
//  CoordinatorProtocol.swift
//  RandomEmoji
//
//  Created by Filipe Santo on 20/01/2022.
//

import Foundation
import UIKit

protocol CoordinatorDelegate: AnyObject {
}

protocol CoordinatorProtocol: AnyObject {
    var navigationController: UINavigationController{ get set }
    var delegate: CoordinatorDelegate? { get set }
    var avatars:[UIImage] { get }
    var emojis:[UIImage] { get }
    var repo:[String] { get }
    
    func start()
    func goToRepository()
    func goToAvatar()
    func goToEmoji()
    func randomEmoji() -> UIImage?
    func setAvatar(name: String)
}
