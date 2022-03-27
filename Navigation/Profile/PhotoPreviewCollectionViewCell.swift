//
//  PhotoPreviewCollectionViewCell.swift
//  Navigation
//
//  Created by Филипп Степанов on 23.11.2021.
//

import UIKit
import StorageDevice

class PhotoPreviewCollectionViewCell: UICollectionViewCell {
    
    var image: UIImage? {
            didSet {
                photo.image = image
            }
        }
        
        var photo: UIImageView = {
            let photo = UIImageView()
            photo.translatesAutoresizingMaskIntoConstraints = false
            photo.clipsToBounds = true
            photo.layer.cornerRadius = 10
            return photo
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            contentView.addSubview(photo)
            let constraintsPhotos = [
                photo.topAnchor.constraint(equalTo: contentView.topAnchor),
                photo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                photo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                photo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
            ]
            NSLayoutConstraint.activate(constraintsPhotos)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
}
