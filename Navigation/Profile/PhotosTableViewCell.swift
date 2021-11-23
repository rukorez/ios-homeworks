//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Филипп Степанов on 20.09.2021.
//

import UIKit
import StorageDevice

class PhotosTableViewCell: UITableViewCell {

    var photo = "photo"
    
    var sectionLabel:UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.text = "Photos"
        return label
    }()
    
    var arrow: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "arrow.right")
        return image
    }()
    
    var photoCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let photoCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        photoCollection.translatesAutoresizingMaskIntoConstraints = false
        photoCollection.backgroundColor = .clear
        photoCollection.showsHorizontalScrollIndicator = false
        return photoCollection
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        photoCollection.delegate = self
        photoCollection.dataSource = self
        photoCollection.register(PhotoPreviewCollectionViewCell.self, forCellWithReuseIdentifier: photo)
        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PhotosTableViewCell {
    private func setViews() {
        contentView.addSubview(sectionLabel)
        contentView.addSubview(arrow)
        contentView.addSubview(photoCollection)
    }
}

// MARK: Констрейнты
extension PhotosTableViewCell {
    private func setConstraints() {
        let constarintsPTVC = [
            sectionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            sectionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            sectionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -110),
            
            arrow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            arrow.centerYAnchor.constraint(equalTo: sectionLabel.centerYAnchor),
            
            photoCollection.topAnchor.constraint(equalTo: sectionLabel.bottomAnchor),
            photoCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoCollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            photoCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
        ]
        NSLayoutConstraint.activate(constarintsPTVC)
    }
}

// MARK: Настройка коллекции
extension PhotosTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photoCollection.dequeueReusableCell(withReuseIdentifier: photo, for: indexPath) as! PhotoPreviewCollectionViewCell
        cell.cell = photos[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (bounds.width - 44) / 4, height: (bounds.width - 44) / 4)
    }
    
}
