//
//  Extension_UIImage.swift
//  RandomEmoji
//
//  Created by Filipe Santo on 20/01/2022.
//

import Foundation
import UIKit

extension UIImage {
    convenience init?(withContentsOfUrl url: URL) throws {
        let imageData = try Data(contentsOf: url)
    
        self.init(data: imageData)
    }
}
