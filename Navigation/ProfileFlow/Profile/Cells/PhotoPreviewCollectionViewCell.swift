//
//  PhotoPreviewCollectionViewCell.swift
//  Navigation
//
//  Created by Филипп Степанов on 23.11.2021.
//

import UIKit
import StorageDevice
import SnapKit

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
        photo.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
