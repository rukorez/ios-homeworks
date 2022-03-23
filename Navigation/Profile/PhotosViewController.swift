//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Филипп Степанов on 22.09.2021.
//

import UIKit
import StorageDevice
import iOSIntPackage

class PhotosViewController: UIViewController {
        
    var photoID = "photoID"
    
    var images: [UIImage] = []
    
    var imagePublisherFacade = ImagePublisherFacade()
    
    var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .white
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Photo Gallery"
        imagePublisherFacade.subscribe(self)
        imagePublisherFacade.addImagesWithTimer(time: 0.1, repeat: 20, userImages: nil)
        view.addSubview(collection)
        self.setConstraints()
        collection.dataSource = self
        collection.delegate = self
        collection.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: photoID)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        imagePublisherFacade.removeSubscription(for: self)
        
        super.viewWillDisappear(animated)
    }
    

}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collection.bounds.width - 32)/3, height: (collection.bounds.width - 32)/3)
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: photoID, for: indexPath) as! PhotosCollectionViewCell
        cell.cell = images[indexPath.item]
        return cell
    }
    
}

// MARK: Реализаци Facade, Observer

extension PhotosViewController: ImageLibrarySubscriber {
    
    func receive(images: [UIImage]) {
        self.images = images
        self.collection.reloadData()
    }
    
}

// MARK: Констрейнты

extension PhotosViewController {
    private func setConstraints() {
        let constraintsPVC = [
            collection.topAnchor.constraint(equalTo: view.topAnchor),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraintsPVC)
    }
}
