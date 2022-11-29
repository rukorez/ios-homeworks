//
//  FeedFlowColors.swift
//  Navigation
//
//  Created by Филипп Степанов on 29.11.2022.
//

import Foundation
import UIKit

class FeedFlowColors {
    
    var feedViewBackgroundColor: UIColor {
        return UIColor.createColor(lightMode: .systemBlue, darkMode: .systemGray6)
    }
    
    var feedViewButtonsTextColor: UIColor {
        return UIColor.createColor(lightMode: .black, darkMode: .white)
    }
    
    var postViewBackgroundColor: UIColor {
        return UIColor.createColor(lightMode: .cyan, darkMode: .systemGray6)
    }
    
    var postViewTimerTextColor: UIColor {
        return UIColor.createColor(lightMode: .black, darkMode: .white)
    }
    
    var infoViewBackgroundColor: UIColor {
        return UIColor.createColor(lightMode: .systemGray, darkMode: .systemGray6)
    }
    
}
