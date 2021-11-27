//
//  Photo.swift
//  Navigation
//
//  Created by Филипп Степанов on 22.09.2021.
//

import Foundation
import UIKit
import iOSIntPackage

public struct Photo {
    
    public var photo: UIImage
    
    public init(photo: UIImage) {
            self.photo = photo
        }
    
}

public var photos: [Photo] = {
    var array: [Photo] = []
    for number in 1...20 {
        guard let image = UIImage(named: String(number)) else { continue }
        array.append(Photo(photo: image))
    }
    return array
}()
