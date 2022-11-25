//
//  ModuleFactory.swift
//  Navigation
//
//  Created by Филипп Степанов on 02.05.2022.
//

import Foundation
import UIKit

final class ProfileModuleFactory: ModuleFactory {
    
    func makeFirstModule() -> UIViewController {
        makeLoginModule()
    }
    
    func makeLoginModule() -> LogInViewController {
        let logInVC = LogInViewController()
        let factory = MyLoginFactory()
        logInVC.delegate = factory.create()
        return logInVC
    }
    
    func makeLoginAlertModule(message: String) -> UIAlertController {
        let alertVC = UIAlertController(title: NSLocalizedString("loginAlertTitle", comment: ""), message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: NSLocalizedString("loginAlertActionOk", comment: ""), style: .default)
        alertVC.addAction(okButton)
        return alertVC
    }
    
    func makeRegisterModule() -> RegisterViewController {
        let registerVC = RegisterViewController()
        let factory = MyLoginFactory()
        registerVC.delegate = factory.create()
        return registerVC
    }
    
    func makeProfileModule(userService: UserService, name: String, statusBarFrame: CGRect) -> ProfileViewController {
        return ProfileViewController(userService: userService, name: name, statusBarFrame: statusBarFrame)
    }
    
    func makePhotosCollectionModule() -> PhotosViewController {
        return PhotosViewController()
    }
    
    func makeFullScreenModule(indexPath: IndexPath) -> FullScreenViewController {
        let fullScreenModule = FullScreenViewController(indexPath: indexPath)
        return fullScreenModule
    }
   
}
