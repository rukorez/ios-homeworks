//
//  FeedViewController.swift
//  Navigation
//
//  Created by Филипп Степанов on 01.08.2021.
//

import UIKit
import StorageDevice

class FeedViewController: UIViewController {

    var post1 = Post(title: "Пост 1")
    
    var button1: CustomButton = {
        let button = CustomButton(title: "Кнопка 1", titleColor: .black, backgroundColor: .clear)
        return button
    }()
    
    var button2: CustomButton = {
        let button = CustomButton(title: "Кнопка 2", titleColor: .white, backgroundColor: .clear)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Лента"
        self.view.backgroundColor = .systemBlue
        
        let stackView = UIStackView(arrangedSubviews: [
            self.button1,
            self.button2
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        self.view.addSubview(stackView)
        let constraintsFVC = [
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraintsFVC)
        
        button1.onTap = {
            self.tap()
        }
        button2.onTap = {
            self.tap()
        }
        
    }
    
    private func tap() {
        let postVC = PostViewController()
        postVC.title = post1.title
        navigationController?.pushViewController(postVC, animated: true)
    }
}
