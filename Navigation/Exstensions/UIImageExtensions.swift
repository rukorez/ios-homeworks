//
//  UIImageExtensions.swift
//  Navigation
//
//  Created by Филипп Степанов on 04.07.2022.
//

import Foundation
import UIKit

// MARK: Расширение для настройки alpha у UIImage

extension UIImage {
    func copy(alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
