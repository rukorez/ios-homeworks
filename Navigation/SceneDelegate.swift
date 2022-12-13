//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Филипп Степанов on 01.08.2021.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        FirebaseApp.configure()
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        if #available(iOS 15, *) {

            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            UINavigationBar.appearance().standardAppearance = navBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance

            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            UITabBar.appearance().standardAppearance = tabBarAppearance
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
        
        let tabBarController = UITabBarController()
        let statusBarFrame = window?.windowScene?.statusBarManager?.statusBarFrame
        coordinator = MainCoordinator(tabBarController: tabBarController, statusBarFrame: statusBarFrame ?? CGRect())
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        coordinator?.start()
        
        let appConfigurator = AppConfiguration.starships
        NetworkService.request(for: appConfigurator)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

