//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Филипп Степанов on 01.08.2021.
//

import UIKit

class ProfileViewController: UIViewController {

    var profileView = ProfileHeaderView()
    
    override func viewDidLoad() {
        self.title = "Профиль"
        self.view.backgroundColor = .lightGray

        self.view.addSubview(self.profileView)
        
        self.profileView.translatesAutoresizingMaskIntoConstraints = false
        [
            self.profileView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.profileView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.profileView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.profileView.heightAnchor.constraint(equalToConstant: 220)
        ]
        .forEach {
            $0.isActive = true
        }
        
        super.viewDidLoad()

    }
    
}
