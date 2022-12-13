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
        feedVC.title = NSLocalizedString("feedViewNavigationTitle", comment: "")
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
        let alertVC = UIAlertController(title: NSLocalizedString("infoAlertTitle", comment: ""), message: NSLocalizedString("infoAlertMessage", comment: ""), preferredStyle: .alert)
        let actionYes = UIAlertAction(title: NSLocalizedString("infoAlertActionYes", comment: ""), style: .default) { _ in
            alertVC.dismiss(animated: true)
            print (NSLocalizedString("infoAlertActionYes", comment: ""))
        }
        alertVC.addAction(actionYes)
        let actionNo = UIAlertAction(title: NSLocalizedString("infoAlertActionNo", comment: ""), style: .default) { _ in print(NSLocalizedString("infoAlertActionNo", comment: ""))}
        alertVC.addAction(actionNo)
        return alertVC
    }
    
}
