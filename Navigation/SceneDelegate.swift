//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Филипп Степанов on 01.08.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.makeKeyAndVisible()
        
//        if #available(iOS 15, *) {
//
//            let navBarAppearance = UINavigationBarAppearance()
//            navBarAppearance.configureWithOpaqueBackground()
//            UINavigationBar.appearance().standardAppearance = navBarAppearance
//            UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
//
//            let tabBarAppearance = UITabBarAppearance()
//            tabBarAppearance.configureWithOpaqueBackground()
//            UITabBar.appearance().standardAppearance = tabBarAppearance
//            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
//        }
        
        let tabBarController = UITabBarController()
        let imageFeed = UIImage(systemName: "scroll")
        let imageProfile = UIImage(systemName: "person")
        
        let feedVC = FeedViewController()
        let feedNC = UINavigationController(rootViewController: feedVC)
        feedNC.tabBarItem = UITabBarItem(title: "Лента", image: imageFeed, tag: 0)
        
        let logInVC = LogInViewController()
        let profileNC = UINavigationController(rootViewController: logInVC)
        profileNC.tabBarItem = UITabBarItem(title: "Профиль", image: imageProfile, tag: 1)
        profileNC.navigationBar.isHidden = true
        profileNC.title = "Профиль"
        
        tabBarController.viewControllers = [feedNC, profileNC]
        
        window?.rootViewController = tabBarController
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

