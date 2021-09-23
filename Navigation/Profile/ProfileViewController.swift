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
        
}

extension ProfileViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0  {
            let photosVC = PhotosViewController()
            self.navigationController?.pushViewController(photosVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = ProfileTableHeaderView()
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
