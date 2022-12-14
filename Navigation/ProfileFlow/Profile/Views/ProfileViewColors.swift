//
//  ProfileViewColors.swift
//  Navigation
//
//  Created by Филипп Степанов on 29.11.2022.
//

import Foundation
import UIKit

class ProfileViewColors {
    
    var labelsTextColor: UIColor {
        return UIColor.createColor(lightMode: .black, darkMode: .white)
    }
    
    var statusBarColor: UIColor {
        return UIColor.createColor(lightMode: .white, darkMode: .black)
    }
    
    var tableViewBackgroundColor: UIColor {
        return UIColor.createColor(lightMode: .systemGray5, darkMode: .black)
    }
    
    var tableViewCellsBackgroundColor: UIColor {
        return UIColor.createColor(lightMode: .white, darkMode: .systemGray6)
    }
    
    func setWhiteViewBackgroundColor(alpha: CGFloat) -> UIColor {
        return UIColor.createColor(lightMode: UIColor(white: 1, alpha: alpha), darkMode: UIColor(white: 0.1, alpha: alpha))
    }
    
}
