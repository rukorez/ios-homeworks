//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Филипп Степанов on 20.09.2021.
//

import UIKit
import StorageDevice
import SnapKit

class PhotosTableViewCell: UITableViewCell {
    
    var coordinator: ProfileCoordinator?

    private var photo = "photo"
    
    lazy var sectionLabel:UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.text = "Photos"
        return label
    }()
    
    lazy var arrow: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "arrow.right")
        return image
    }()
    
    lazy var photoCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let photoCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
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
        
        sectionLabel.snp.makeConstraints { (maker) in
            maker.top.leading.equalToSuperview().offset(12)
        }
        
        arrow.snp.makeConstraints { (maker) in
            maker.trailing.equalToSuperview().offset(-12)
            maker.centerY.equalTo(sectionLabel.snp.centerY)
        }
        
        photoCollection.snp.makeConstraints { (maker) in
            maker.leading.trailing.bottom.equalToSuperview()
            maker.top.equalTo(sectionLabel.snp.bottom)
            maker.height.equalTo(120)
        }
    }
}

// MARK: Настройка коллекции
extension PhotosTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photoCollection.dequeueReusableCell(withReuseIdentifier: photo, for: indexPath) as! PhotoPreviewCollectionViewCell
        cell.image = photos[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width - 44) / 4, height: (collectionView.bounds.width - 44) / 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coordinator?.showFullScreenModule(indexPath: indexPath)
    }
    
}
