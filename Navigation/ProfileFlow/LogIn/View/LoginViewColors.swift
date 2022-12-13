//
//  LoginViewColors.swift
//  Navigation
//
//  Created by Филипп Степанов on 29.11.2022.
//

import Foundation
import UIKit

class LoginViewColors {
    
    var backgroundColor: UIColor {
        return UIColor.createColor(lightMode: UIColor.white, darkMode: UIColor.black)
    }
    
    var loginViewBackgroundColor: UIColor {
        return UIColor.createColor(lightMode: .systemGray6, darkMode: .systemGray5)
    }
    
    var loginTextColor: UIColor {
        return UIColor.createColor(lightMode: .black, darkMode: .white)
    }
    
}
