//
//  FullScreenViewController.swift
//  Navigation
//
//  Created by Филипп Степанов on 03.06.2022.
//

import UIKit
import StorageDevice

final class FullScreenViewController: UIViewController {
    
    var coordinator: ProfileCoordinator?
    
    var indexPath: IndexPath
    
    private var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled = true
        return collection
    }()
    
    init(indexPath: IndexPath) {
        self.indexPath = indexPath
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupCollectionView()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        
        super.viewWillDisappear(animated)
    }
    
    private func setupUI() {
        title = NSLocalizedString("fullScreenViewNavigationTitle", comment: "")
        view.backgroundColor = .white
    }
    
    private func setupCollectionView() {
        view.addSubview(collection)
        collection.dataSource = self
        collection.delegate = self
        collection.register(FullScreenCollectionViewCell.self, forCellWithReuseIdentifier: "fullscreen")
        collection.performBatchUpdates(nil) { [ weak self ] result in
            self?.collection.scrollToItem(at: self?.indexPath ?? IndexPath(), at: .centeredHorizontally, animated: false)
        }
    }
    
}

// MARK: - Методы CollectionView

extension FullScreenViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "fullscreen", for: indexPath) as! FullScreenCollectionViewCell
        cell.imageView.image = photos[indexPath.row]
        return cell
    }
    
    
}

extension FullScreenViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collection.bounds.width, height: collection.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
        
}

// MARK: - Констрейнты

extension FullScreenViewController {
    
    private func setConstraints() {
        let constraints = [
            
            collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}

