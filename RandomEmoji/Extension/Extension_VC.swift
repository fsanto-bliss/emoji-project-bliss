//
//  Extension_VC.swift
//  RandomEmoji
//
//  Created by Filipe Santo on 21/01/2022.
//

import Foundation
import UIKit

extension UIViewController {
    class func loadFromNibNamed(nibNamed: String, bundle : Bundle? = nil) -> UIViewController? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
        ).instantiate(withOwner: nil, options: nil)[0] as? UIViewController

    }

}
