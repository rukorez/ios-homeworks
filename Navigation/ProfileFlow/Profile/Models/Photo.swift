//
//  Photo.swift
//  Navigation
//
//  Created by Филипп Степанов on 22.09.2021.
//

import Foundation
import UIKit

public var photos: [UIImage] = {
    var array: [UIImage] = []
    for number in 1...20 {
        guard let image = UIImage(named: String(number)) else { continue }
        array.append(image)
    }
    return array
}()
