//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Филипп Степанов on 13.05.2022.
//

import UIKit

// MARK: - класс координаторов для контроллеров потока Profile

final class ProfileCoordinator: Coordinator {
    
    var rootVC: UIViewController {
        return navigationController
    }
    
    private var navigationController: UINavigationController
    private var factory: ProfileModuleFactory
    
    var statusBarFrame: CGRect
    
    init(factory: ProfileModuleFactory, statusBarFrame: CGRect) {
        self.statusBarFrame = statusBarFrame
        self.navigationController = UINavigationController()
        self.factory = factory
    }
    
    func start() {
        showLoginModule()
    }
    
    func showLoginModule() {
        let loginVC = factory.makeLoginModule()
        loginVC.coordinator = self
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(loginVC, animated: true)
    }
    
    func showProfileModule(userService: UserService, name: String) {
        let profileModule = factory.makeProfileModule(userService: userService, name: name, statusBarFrame: statusBarFrame)
        profileModule.coordinator = self
        navigationController.pushViewController(profileModule, animated: true)
    }
    
    func showPhotosCollectionModule() {
        let photosCollectionModule = factory.makePhotosCollectionModule()
        photosCollectionModule.coordinator = self
        navigationController.pushViewController(photosCollectionModule, animated: true)
    }
    
    func showFullScreenModule(indexPath: IndexPath) {
        let fullScreenModule = FullScreenViewController(indexPath: indexPath)
        fullScreenModule.coordinator = self
        navigationController.pushViewController(fullScreenModule, animated: true)
    }
    
}
