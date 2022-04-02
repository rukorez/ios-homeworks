//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Филипп Степанов on 01.08.2021.
//

import UIKit
import StorageDevice

class ProfileViewController: UIViewController {
    
    lazy var tableView = UITableView(frame: .zero, style: .grouped)
    
    var headerView = ProfileHeaderView(reuseIdentifier: "header")
    
    lazy var whiteView: UIView = {
        var whiteView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        whiteView.backgroundColor = UIColor(white: 1, alpha: 0)
        return whiteView
    }()
    
    
    lazy var closeButton: UIButton = {
        var button = UIButton(frame: CGRect(x: view.bounds.width - 50, y: 60, width: 30, height: 25))
        button.setBackgroundImage(UIImage(systemName: "multiply"), for: .normal)
        button.addTarget(self, action: #selector(closeAvatar), for: .touchUpInside)
        return button
    }()
    
    private var cellID = "cellID"
    private var cellID2 = "cellID2"
    
    var userService: UserService
    
    var user: User
    
    init(userService: UserService, name: String) {
        self.userService = userService
        self.user = userService.userName(name: name)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(whiteView)
        setupTableView()
        setConstraintsPVC()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        #if DEBUG
        tableView.backgroundColor = .systemGray5
        #else
        tableView.backgroundColor = UIColor(named: "VKBlue")
        #endif
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: cellID2)
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: "header")
    }
    
}

// MARK: Таблица
extension ProfileViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0  {
            let photosVC = PhotosViewController()
            navigationController?.pushViewController(photosVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! ProfileHeaderView
            let gesture = UITapGestureRecognizer(target: self, action: #selector(avatarTapped))
            headerView.addGestureRecognizer(gesture)
            return headerView
        } else { return nil }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0  { return 210 }
        else { return 0 }
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
            cell.post = posts[indexPath.row]
            return cell
        }
    }
}

// MARK: Констрейнты
extension ProfileViewController {
    func setConstraintsPVC() {
        let constraintsPVC = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraintsPVC)
    }
}

// MARK: Анимация

extension ProfileViewController {
    
    @objc func avatarTapped() {
        view.addSubview(whiteView)
        whiteView.addSubview(headerView.avatarImageView)
        headerView.avatarImageView.layer.borderWidth = 0
        UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseOut) {
            self.whiteView.backgroundColor = UIColor(white: 1, alpha: 0.9)
            self.headerView.avatarImageView.clipsToBounds = false
            self.headerView.avatarImageView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.width)
            self.headerView.avatarImageView.center = self.tableView.center
        } completion: { _ in
            self.whiteView.addSubview(self.closeButton)
        }
    }
    
    @objc func closeAvatar() {
        UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseIn) {
            self.headerView.avatarImageView.frame = CGRect(x: 16, y: 16, width: 110, height: 110)
            self.headerView.avatarImageView.layer.borderWidth = CGFloat(3)
            self.headerView.avatarImageView.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 10)
            self.headerView.avatarImageView.layer.cornerRadius = self.headerView.avatarImageView.bounds.height / 2
            self.headerView.avatarImageView.clipsToBounds = true
            self.whiteView.backgroundColor = UIColor(white: 1, alpha: 0)
        }
        whiteView.removeFromSuperview()
        headerView.contentView.addSubview(headerView.avatarImageView)
        closeButton.removeFromSuperview()
    }
}
