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

    var post: Posts? {
        didSet {
            author.text = post?.author
            let processor = ImageProcessor()
            if let image = post?.image {
                processor.processImage(sourceImage: image, filter: .chrome) { image in
                    self.image.image = image
                }
            }
            text.text = post?.description
            if let stingLikes = post?.likes {
                let formatted = String(format: NSLocalizedString("postTableViewCellLikes", comment: ""), stingLikes)
                likes.text = formatted
            }
            if let stringViews = post?.views {
                views.text = "\(NSLocalizedString("postTableViewCellViews", comment: "")): \(stringViews)"
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
            author.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            author.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            image.topAnchor.constraint(equalTo: author.bottomAnchor, constant: 12),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            image.bottomAnchor.constraint(equalTo: text.topAnchor, constant: -16),
            image.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            image.heightAnchor.constraint(equalTo: image.widthAnchor),
            
            text.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 16),
            text.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            text.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            likes.topAnchor.constraint(equalTo: text.bottomAnchor, constant: 16),
            likes.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            likes.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            views.topAnchor.constraint(equalTo: text.bottomAnchor, constant: 16),
            views.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            views.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(constraintsPostTVC)
    }
}
