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
        return [feedCoordinator, profileCoordinator]
    }
    
    var statusBarFrame: CGRect
    
    var controllers: [UIViewController] = []
    
    var feedCoordinator: FeedCoordinator
    
    var profileCoordinator: ProfileCoordinator
    
    var tabBarController: UITabBarController
    
    init(tabBarController: UITabBarController, statusBarFrame: CGRect) {
        self.statusBarFrame = statusBarFrame
        self.tabBarController = tabBarController
        feedCoordinator = FeedCoordinator(factory: FeedModuleFactory())
        let feedController = feedCoordinator.rootVC
        feedController.tabBarItem = UITabBarItem(title: "Лента", image: UIImage(systemName: "scroll"), tag: 0)
        controllers.append(feedController)
        profileCoordinator = ProfileCoordinator(factory: ProfileModuleFactory(), statusBarFrame: statusBarFrame)
        let profileController = profileCoordinator.rootVC
        profileController.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person"), tag: 1)
        controllers.append(profileController)
    }
    
    func start() {
        tabBarController.viewControllers = controllers
        childCoordinators.forEach( { $0.start() } )
    }
    
}
