//
//  PostViewController.swift
//  Navigation
//
//  Created by Филипп Степанов on 02.08.2021.
//

import UIKit

final class PostViewController: UIViewController {
    
    weak var coordinator: FeedCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    private func setView() {
        view.backgroundColor = .cyan
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Информация", style: .done, target: self, action: #selector(tap))
    }
    
    @objc private func tap() {
        coordinator?.showInfoModule(controller: self)
    }
    
}
