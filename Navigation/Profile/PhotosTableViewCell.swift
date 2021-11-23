//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Филипп Степанов on 20.09.2021.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {

    var sectionLabel:UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.text = "Photos"
        return label
    }()
    
    var image1: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "1")
        image.clipsToBounds = true
        image.layer.cornerRadius = 6
        return image
    }()
    
    var image2: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "2")
        image.clipsToBounds = true
        image.layer.cornerRadius = 6
        return image
    }()
    
    var image3: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "3")
        image.clipsToBounds = true
        image.layer.cornerRadius = 6
        return image
    }()
    
    var image4: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "4")
        image.clipsToBounds = true
        image.layer.cornerRadius = 6
        return image
    }()
    
    var arrow: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "arrow.right")
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setViews()
        self.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PhotosTableViewCell {
    private func setViews() {
        contentView.addSubview(sectionLabel)
        contentView.addSubview(image1)
        contentView.addSubview(image2)
        contentView.addSubview(image3)
        contentView.addSubview(image4)
        contentView.addSubview(arrow)
    }
}

// MARK: Констрейнты

extension PhotosTableViewCell {
    private func setConstraints() {
        let constarintsPTVC = [
            sectionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            sectionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            arrow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            arrow.centerYAnchor.constraint(equalTo: sectionLabel.centerYAnchor),
            
            image1.topAnchor.constraint(equalTo: sectionLabel.bottomAnchor, constant: 12),
            image1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            image1.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            image1.heightAnchor.constraint(equalToConstant: (contentView.bounds.width-48)/4),
            image1.widthAnchor.constraint(equalTo: image1.heightAnchor),
            
            image2.topAnchor.constraint(equalTo: sectionLabel.bottomAnchor, constant: 12),
            image2.leadingAnchor.constraint(equalTo: image1.trailingAnchor, constant: 8),
            image2.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            image2.heightAnchor.constraint(equalToConstant: (contentView.bounds.width-48)/4),
            image2.widthAnchor.constraint(equalTo: image1.heightAnchor),
            
            image3.topAnchor.constraint(equalTo: sectionLabel.bottomAnchor, constant: 12),
            image3.leadingAnchor.constraint(equalTo: image2.trailingAnchor, constant: 8),
            image3.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            image3.heightAnchor.constraint(equalToConstant: (contentView.bounds.width-48)/4),
            image3.widthAnchor.constraint(equalTo: image1.heightAnchor),
            
            image4.topAnchor.constraint(equalTo: sectionLabel.bottomAnchor, constant: 12),
            image4.leadingAnchor.constraint(equalTo: image3.trailingAnchor, constant: 8),
            image4.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            image4.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            image4.heightAnchor.constraint(equalToConstant: (contentView.bounds.width-48)/4),
            image4.widthAnchor.constraint(equalTo: image1.heightAnchor),
        ]
        NSLayoutConstraint.activate(constarintsPTVC)
    }
}
