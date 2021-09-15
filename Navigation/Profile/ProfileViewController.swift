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
    }
    
}

extension ProfileViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = ProfileTableHeaderView()
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 220
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! PostTableViewCell
        cell.cell = posts[indexPath.row]
        return cell
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
