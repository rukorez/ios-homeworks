//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Филипп Степанов on 22.09.2021.
//

import UIKit
import StorageDevice

class PhotosCollectionViewCell: UICollectionViewCell {
    
    var cell: UIImage? {
        didSet {
            photo.image = cell
        }
    }
    
    var photo: UIImageView = {
        let photo = UIImageView()
        photo.translatesAutoresizingMaskIntoConstraints = false
        return photo
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(photo)
        let constraintsPhotos = [
            photo.topAnchor.constraint(equalTo: self.topAnchor),
            photo.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            photo.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            photo.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ]
        NSLayoutConstraint.activate(constraintsPhotos)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
