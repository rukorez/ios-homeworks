//
//  FavoriteCoordinator.swift
//  Navigation
//
//  Created by Филипп Степанов on 14.09.2022.
//

import Foundation
import UIKit

final class FavoriteCoordinator: Coordinator {
    
    var rootVC: UIViewController {
        return navigationController
    }
    
    private var navigationController: UINavigationController
    private var factory: FavoriteModuleFactory
    
    init(factory: FavoriteModuleFactory) {
        self.navigationController = UINavigationController()
        self.factory = factory
    }
    
    func start() {
        showFavoritePostsModule()
    }
    
    func showFavoritePostsModule() {
        let favoriteVC = factory.makeFavoritePostsModule()
        favoriteVC.coordinator = self
        favoriteVC.title = "Избранное"
        navigationController.pushViewController(favoriteVC, animated: true)
    }
    
}
