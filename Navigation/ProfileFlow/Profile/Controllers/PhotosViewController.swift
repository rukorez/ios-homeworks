//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Филипп Степанов on 22.09.2021.
//

import UIKit
import StorageDevice
import iOSIntPackage

final class PhotosViewController: UIViewController {
    
    weak var coordinator: ProfileCoordinator?
            
    private var images: [UIImage] = photos {
        didSet {
            self.collection.reloadData()
        }
    }
    
    private var imagePublisherFacade = ImagePublisherFacade()
    
    var imageProcessor = ImageProcessor()
    
    private var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .white
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
//        setImagePublisherFacade()
//        benchmarkBackgrpundQOS()
//        benchmarkDefaultQOS()
//        benchmarkUserInteractiveQOS()
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
    
    private func setViews() {
        navigationItem.title = "Photo Gallery"
        view.addSubview(collection)
        setConstraints()
        collection.dataSource = self
        collection.delegate = self
        collection.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.photoID)
    }
    
    private func setImagePublisherFacade() {
        imagePublisherFacade.subscribe(self)
        imagePublisherFacade.addImagesWithTimer(time: 0.1, repeat: 20, userImages: photos)
    }
    

}

// MARK: - Методы CollectionView

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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coordinator?.showFullScreenModule(indexPath: indexPath)
    }
    
}

extension PhotosViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.photoID, for: indexPath) as! PhotosCollectionViewCell
//        print("indexpath \(indexPath)")
        cell.image = images[indexPath.row]
        return cell
    }
    
}

// MARK: - Реализаци Facade, Observer

extension PhotosViewController: ImageLibrarySubscriber {
    
    func receive(images: [UIImage]) {
        self.images = images
    }
    
}

// MARK: - Констрейнты

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

// MARK: - Измерение скорости потоков

extension PhotosViewController {
    
    func benchmarkBackgrpundQOS() {
        let startTime = Date()
        imageProcessor.processImagesOnThread(sourceImages: images, filter: .fade, qos: .background) { [weak self] images in
            print("backgroundQOS")
            DispatchQueue.main.async {
                var newImages: [UIImage] = []
                images.forEach { image in
                    guard let newImage = image else { return }
                    newImages.append(UIImage(cgImage: newImage))
                }
                self?.images = newImages
            }
        }
        let endTime = Date()
        
        let timeElapsed = endTime.timeIntervalSince(startTime)
        print("Time elapsed: \(timeElapsed) s for backgroundQOS")
    }
    
    func benchmarkDefaultQOS() {
        let startTime = Date()
        imageProcessor.processImagesOnThread(sourceImages: images, filter: .chrome, qos: .default) { [weak self] images in
            print("defaultQOS")
            DispatchQueue.main.async {
                var newImages: [UIImage] = []
                images.forEach { image in
                    guard let newImage = image else { return }
                    newImages.append(UIImage(cgImage: newImage))
                }
                self?.images = newImages
            }
        }
        let endTime = Date()
        
        let timeElapsed = endTime.timeIntervalSince(startTime)
        print("Time elapsed: \(timeElapsed) s for defaultQOS")
        }
    
    func benchmarkUserInteractiveQOS() {
        let startTime = Date()
        imageProcessor.processImagesOnThread(sourceImages: images, filter: .sepia(intensity: 1), qos: .userInteractive) { [ weak self ] images in
            print("userInteractiveQOS")
            DispatchQueue.main.async {
                var newImages: [UIImage] = []
                images.forEach { image in
                    guard let newImage = image else { return }
                    newImages.append(UIImage(cgImage: newImage))
                }
                self?.images = newImages
            }
        }
        let endTime = Date()
        
        let timeElapsed = endTime.timeIntervalSince(startTime)
        print("Time elapsed: \(timeElapsed) s userInteractiveQOS")
    }
    
}
