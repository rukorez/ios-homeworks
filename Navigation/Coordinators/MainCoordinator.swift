//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Филипп Степанов on 02.05.2022.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    
    var rootVC: UIViewController {
        return tabBarController
    }
    
    var childCoordinators: [Coordinator] {
        return [feedCoordinator, profileCoordinator, favoriteCoordinator, playerCoordinator, mapCoordinator]
    }
    
    var statusBarFrame: CGRect
    
    var controllers: [UIViewController] = []
    
    var feedCoordinator: FeedCoordinator
    
    var profileCoordinator: ProfileCoordinator
    
    var playerCoordinator: PlayerCoordinator
    
    var favoriteCoordinator: FavoriteCoordinator
    
    var mapCoordinator: MapCoordinator
    
    var tabBarController: UITabBarController
    
    init(tabBarController: UITabBarController, statusBarFrame: CGRect) {
        self.statusBarFrame = statusBarFrame
        self.tabBarController = tabBarController
        feedCoordinator = FeedCoordinator(factory: FeedModuleFactory())
        let feedController = feedCoordinator.rootVC
        feedController.tabBarItem = UITabBarItem(title: NSLocalizedString("feedControllerTabTitle", comment: ""), image: UIImage(systemName: "scroll"), tag: 0)
        controllers.append(feedController)
        profileCoordinator = ProfileCoordinator(factory: ProfileModuleFactory(), statusBarFrame: statusBarFrame)
        let profileController = profileCoordinator.rootVC
        profileController.tabBarItem = UITabBarItem(title: NSLocalizedString("profileControllerTabTitle", comment: ""), image: UIImage(systemName: "person"), tag: 1)
        controllers.append(profileController)
        favoriteCoordinator = FavoriteCoordinator(factory: FavoriteModuleFactory())
        let favoriteController = favoriteCoordinator.rootVC
        favoriteController.tabBarItem = UITabBarItem(title: NSLocalizedString("favoriteControllerTabTitle", comment: ""), image: UIImage(systemName: "star"), tag: 2)
        controllers.append(favoriteController)
        playerCoordinator = PlayerCoordinator(factory: PlayerModuleFactory())
        let playerController = playerCoordinator.rootVC
        playerController.tabBarItem = UITabBarItem(title: NSLocalizedString("playerControllerTabTitle", comment: ""), image: UIImage(systemName: "play"), tag: 3)
        controllers.append(playerController)
        mapCoordinator = MapCoordinator(factory: MapModuleFactory())
        let mapController = mapCoordinator.rootVC
        mapController.tabBarItem = UITabBarItem(title: NSLocalizedString("mapControllerTabTitle", comment: ""), image: UIImage(systemName: "map"), tag: 4)
        controllers.append(mapController)
    }
    
    func start() {
        tabBarController.viewControllers = controllers
        childCoordinators.forEach( { $0.start() } )
    }
    
}
