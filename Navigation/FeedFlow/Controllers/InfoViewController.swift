//
//  InfoViewController.swift
//  Navigation
//
//  Created by Филипп Степанов on 03.08.2021.
//

import UIKit

final class InfoViewController: UIViewController {
    
    weak var coordinator: FeedCoordinator?
    
     var buttonDelete: CustomButton = {
        let button = CustomButton(title: "Удалить все", titleColor: .white, backgroundColor: .clear)
        button.frame = CGRect(x: 100, y: 350, width: 200, height: 50)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
    }
    
    private func setViews() {
        view.addSubview(buttonDelete)
        view.backgroundColor = .systemGray
        buttonDelete.onTap = {
            self.tap()
        }
    }
    
     func tap() {
         coordinator?.showAlertModule(controller: self)
     }


}
