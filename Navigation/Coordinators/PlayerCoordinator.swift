//
//  PlayerCoordinator.swift
//  Navigation
//
//  Created by Филипп Степанов on 07.08.2022.
//

import UIKit

final class PlayerCoordinator: Coordinator {
    
    var rootVC: UIViewController {
        return navigationController
    }
    
    private var navigationController: UINavigationController
    private var factory: PlayerModuleFactory
    
    init(factory: PlayerModuleFactory) {
        self.navigationController = UINavigationController()
        self.factory = factory
    }
    
    func start() {
        showPlayerModule()
    }
    
    func showPlayerModule() {
        let playerVC = factory.makePlayerModule()
        playerVC.coordinator = self
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(playerVC, animated: true)
    }
}
