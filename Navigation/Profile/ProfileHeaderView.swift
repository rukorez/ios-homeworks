//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Филипп Степанов on 26.08.2021.
//

import UIKit

class ProfileHeaderView: UIView {
    
    var avatar = UIImageView()
    
    var photo = UIImage(named: "Ava")
    
    var name = UILabel()
    
    var status = UITextView()
    
    var statusButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(avatar)
        avatar.image = photo
        avatar.clipsToBounds = true
        avatar.layer.cornerRadius = avatar.frame.size.width/2
        avatar.layer.borderWidth = CGFloat(3)
        avatar.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 10)
        
        self.addSubview(name)
        name.text = "Alco Dog"
        name.textColor = .black
        name.font = UIFont.boldSystemFont(ofSize: 18)
        
        self.addSubview(status)
        status.text = "Waiting for drink..."
        status.textColor = .gray
        status.font = status.font?.withSize(14)
        status.backgroundColor = .lightGray
        
        self.addSubview(statusButton)
        statusButton.backgroundColor = .systemBlue
        statusButton.setTitle("Show Status", for: .normal)
        statusButton.setTitleColor(UIColor.white, for: .normal)
        statusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
    }
    
    @objc func buttonPressed() {
        if let currentStatus = self.status.text {
            print(currentStatus)            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
