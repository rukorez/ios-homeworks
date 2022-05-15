//
//  TabBarFarctory.swift
//  Navigation
//
//  Created by Филипп Степанов on 02.05.2022.
//

import Foundation
import UIKit

final class FeedModuleFactory: ModuleFactory {
    
    func makeFirstModule() -> UIViewController {
        return makeFeedModule().view
    }
    
    func makeFeedModule() -> (presenter: FeedPresenter, view: FeedViewController) {
        let presenter = FeedPresenter()
        let feedVC = FeedViewController(output: presenter)
        feedVC.title = "Лента"
        presenter.input = feedVC
        presenter.sendData()
        return (presenter, feedVC)
    }
    
    func makePostModule(title: String) -> PostViewController {
        let postVC = PostViewController()
        postVC.title = title
        return postVC
    }
    
    func makeInfoModule() -> InfoViewController {
        let infoVC = InfoViewController()
        infoVC.modalPresentationStyle = .automatic
        return infoVC
    }
    
    func makeInfoAlert() -> UIAlertController {
        let alertVC = UIAlertController(title: "Удаление", message: "Удалить всю информацию?", preferredStyle: .alert)
        let actionYes = UIAlertAction(title: "Да", style: .default) { _ in print ("Да")}
        alertVC.addAction(actionYes)
        let actionNo = UIAlertAction(title: "Нет", style: .default) { _ in print("Нет")}
        alertVC.addAction(actionNo)
        return alertVC
    }
    
}
