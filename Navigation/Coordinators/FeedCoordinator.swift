//
//  ChildCoordinator.swift
//  Navigation
//
//  Created by Филипп Степанов on 02.05.2022.
//

import Foundation
import UIKit

// MARK: - класс координаторов для контроллеров потока Feed

final class FeedCoordinator: Coordinator {
    
    var rootVC: UIViewController {
        return navigationController
    }
    
    private var navigationController: UINavigationController
    private var factory: FeedModuleFactory
    
    init(factory: FeedModuleFactory) {
        self.navigationController = UINavigationController()
        self.factory = factory
    }
    
    func start() {
        showFeedModule()
    }
    
    func showFeedModule() {
        let feedModule = factory.makeFeedModule()
        feedModule.presenter.coordinator = self
        navigationController.pushViewController(feedModule.view, animated: true)
    }
    
    func showPostModule(title: String) {
        let postVC = factory.makePostModule(title: title)
        postVC.coordinator = self
        navigationController.pushViewController(postVC, animated: true)
    }
    
    func showInfoModule(controller: UIViewController) {
        let infoVC = factory.makeInfoModule()
        infoVC.coordinator = self
        controller.present(infoVC, animated: true)
    }
    
    func showAlertModule(controller: UIViewController) {
        let alertVC = factory.makeInfoAlert()
        controller.present(alertVC, animated: true, completion: nil)
    }
    
}
