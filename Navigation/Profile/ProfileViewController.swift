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
        super.viewDidLoad()
        
    }
    
    override func viewWillLayoutSubviews() {
        profileView.frame = self.view.frame
        
        profileView.avatar.frame = CGRect(x: 16, y: self.view.safeAreaInsets.top + 16, width: 100, height: 100)
        profileView.avatar.clipsToBounds = true
        profileView.avatar.layer.cornerRadius = profileView.avatar.frame.size.width/2
        
        profileView.name.frame = CGRect(x: self.view.center.x - 50, y: self.view.safeAreaInsets.top + 22, width: 200, height: 20)
        
        profileView.status.frame = CGRect(x: self.view.center.x - 50, y: self.view.safeAreaInsets.top + 22 + self.profileView.name.bounds.height + 10, width: 200, height: 25)
        
        profileView.statusEdit.frame = CGRect(x: self.view.center.x - 50, y: self.view.safeAreaInsets.top + 22 + self.profileView.name.bounds.height + 16 + self.profileView.status.bounds.height, width: 200, height: 40)
        profileView.statusEdit.layer.cornerRadius = 10
        
        profileView.statusButton.frame = CGRect(x: 16, y: self.view.safeAreaInsets.top + 16 + self.profileView.avatar.bounds.height + 16, width: self.view.frame.width - 32, height: 50)
        profileView.statusButton.layer.cornerRadius = 10
        profileView.statusButton.layer.shadowOffset.width = 4
        profileView.statusButton.layer.shadowOffset.height = 4
        profileView.statusButton.layer.shadowRadius = 4
        profileView.statusButton.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 10)
        profileView.statusButton.layer.shadowOpacity = 0.7
        
        
    }
    


}
