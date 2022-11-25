//
//  MapCoordinator.swift
//  Navigation
//
//  Created by Филипп Степанов on 10.11.2022.
//

import Foundation
import UIKit

final class MapCoordinator: Coordinator {
    
    var rootVC: UIViewController {
        return navigationController
    }
    
    private var navigationController: UINavigationController
    private var factory: MapModuleFactory
    
    init(factory: MapModuleFactory) {
        self.navigationController = UINavigationController()
        self.factory = factory
    }
    
    func start() {
        showMapModule()
    }
    
    func showMapModule() {
        let mapVC = factory.makeMapModule()
        mapVC.coordinator = self
        navigationController.isNavigationBarHidden = true
        navigationController.pushViewController(mapVC, animated: true)
    }
    
}
