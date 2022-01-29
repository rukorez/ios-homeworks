//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Филипп Степанов on 14.09.2021.
//

import UIKit
import StorageDevice
import iOSIntPackage

class PostTableViewCell: UITableViewCell {

    var cell: Posts? {
        didSet {
            author.text = cell?.author
            let processor = ImageProcessor()
            if let image = cell?.image {
                processor.processImage(sourceImage: image, filter: .chrome) { image in
                    self.image.image = image
                }
            }
            text.text = cell?.description
            if let stingLikes = cell?.likes {
                likes.text = "Likes: \(stingLikes)"
            }
            if let stringViews = cell?.views {
                views.text = "Views: \(stringViews)"
            }
        }
    }
        
    lazy var author: UILabel = {
        let author = UILabel()
        author.translatesAutoresizingMaskIntoConstraints = false
        author.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        author.textColor = .black
        author.numberOfLines = 2
        return author
    }()
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .black
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var text: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        text.textColor = .systemGray
        text.numberOfLines = 0
        return text
    }()
    
    lazy var likes: UILabel = {
        var likes = UILabel()
        likes.translatesAutoresizingMaskIntoConstraints = false
        likes.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        likes.textColor = .black
        return likes
    }()
    
    lazy var views: UILabel = {
        var views = UILabel()
        views.translatesAutoresizingMaskIntoConstraints = false
        views.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        views.textColor = .black
        return views
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setViews()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setViews()
        setConstraint()
    }
    
}

extension PostTableViewCell {
    private func setViews() {
        contentView.addSubview(author)
        contentView.addSubview(image)
        contentView.addSubview(text)
        contentView.addSubview(likes)
        contentView.addSubview(views)
    }
}

// MARK: Констрейнты

extension PostTableViewCell {
    private func setConstraint() {
        let constraintsPostTVC = [
            self.author.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            self.author.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            self.image.topAnchor.constraint(equalTo: author.bottomAnchor, constant: 12),
            self.image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            self.image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            self.image.bottomAnchor.constraint(equalTo: text.topAnchor, constant: -16),
            self.image.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            self.image.heightAnchor.constraint(equalTo: image.widthAnchor),
            
            self.text.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 16),
            self.text.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            self.text.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            self.likes.topAnchor.constraint(equalTo: text.bottomAnchor, constant: 16),
            self.likes.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            self.likes.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            self.views.topAnchor.constraint(equalTo: text.bottomAnchor, constant: 16),
            self.views.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            self.views.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(constraintsPostTVC)
    }
}
