//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Филипп Степанов on 01.08.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var posts: [Posts] = [post1, post2, post3, post4]

    var tableView = UITableView(frame: .zero, style: .grouped)
    
    let headerView = ProfileTableHeaderView()
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "multiply"), for: .normal)
        button.addTarget(self, action: #selector(closeAvatar), for: .touchUpInside)
        return button
    }()
    
    var whiteView = UIView()
    
    var cellID = "cellID"
    var cellID2 = "cellID2"
    
    override func viewDidLoad() {
        self.setupTableView()
        self.setConstraintsPVC()
        
        super.viewDidLoad()
    }
        
    func setupTableView() {
        self.view.backgroundColor = .lightGray
        self.view.addSubview(tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(PostTableViewCell.self, forCellReuseIdentifier: cellID)
        self.tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: cellID2)
    }
    
    @objc func avatarTapped() {
        self.view.addSubview(whiteView)
        self.whiteView.addSubview(self.headerView.profileView.avatarImageView)
        self.view.addSubview(closeButton)
        self.headerView.profileView.avatarImageView.translatesAutoresizingMaskIntoConstraints = true
        self.headerView.profileView.avatarImageView.frame = CGRect(x: 16, y: self.view.safeAreaInsets.top + 16, width: 110, height: 110)
        self.whiteView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 1, animations: {
                self.headerView.profileView.avatarImageView.center = self.view.center
                let scaleFactor = self.view.bounds.width / self.headerView.profileView.avatarImageView.bounds.width
                self.headerView.profileView.avatarImageView.transform = self.headerView.profileView.avatarImageView.transform.scaledBy(x: scaleFactor, y: scaleFactor)
                self.viewDidLayoutSubviews()
            })
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 1, animations: {
                self.whiteView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
            })
        }, completion: { _ in
            NSLayoutConstraint.activate([self.closeButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
                                         self.closeButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16)])
            
        })
    }
    
    @objc func closeAvatar() {
        UIView.animate(withDuration: 0.5, animations: {
            self.whiteView.removeFromSuperview()
            self.closeButton.removeFromSuperview()
            self.headerView.profileView.avatarImageView.transform = .identity
            self.headerView.profileView.avatarImageView.frame = CGRect(x: 16, y: 16, width: 110, height: 110)
            self.headerView.profileView.addSubview(self.headerView.profileView.avatarImageView)
            self.headerView.profileView.avatarImageView.translatesAutoresizingMaskIntoConstraints = false
            self.headerView.profileView.setConstraintsPHV()
            self.headerView.profileView.setNeedsLayout()
        })
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.headerView.profileView.avatarImageView.layer.cornerRadius = 0
    }
}

// MARK: Таблица

extension ProfileViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0  {
            let photosVC = PhotosViewController()
            self.navigationController?.pushViewController(photosVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(avatarTapped))
        headerView.profileView.avatarImageView.addGestureRecognizer(gesture)
        if section == 0  { return headerView }
        else { return nil }
    }
    
}

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0  { return 1 }
        else { return posts.count }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID2, for: indexPath) as! PhotosTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! PostTableViewCell
            cell.cell = posts[indexPath.row]
            return cell
        }
    }
}

// MARK: Констрейнты

extension ProfileViewController {
    func setConstraintsPVC() {
        let constraintsPVC = [
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraintsPVC)
    }
}

