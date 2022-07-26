//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Филипп Степанов on 01.08.2021.
//

import UIKit
import StorageDevice

final class ProfileViewController: UIViewController {
    
    weak var coordinator: ProfileCoordinator?
    
    var statusBarFrame: CGRect
    var statusBarView: UIView = {
        var statusBar = UIView()
        statusBar.backgroundColor = .white
        statusBar.alpha = 0
        return statusBar
    }()
    
    lazy var tableView: UITableView = {
        var tableView = UITableView(frame: .zero, style: .grouped)
        #if DEBUG
        tableView.backgroundColor = .systemGray5
        #else
        tableView.backgroundColor = UIColor(named: "VKBlue")
        #endif
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: Identificators.cellID)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: Identificators.cellID2)
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: Identificators.header)
        return tableView
    }()
    
    var headerView = ProfileHeaderView(reuseIdentifier: Identificators.header)
    
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
    
    private enum Identificators {
        static let cellID = "cellID"
        static let cellID2 = "cellID2"
        static let header = "header"
    }
    
    var userService: UserService
    
    var user: User?
    
    init(userService: UserService, name: String, statusBarFrame: CGRect) {
        self.userService = userService
        do {
            let user = try userService.userName(name: name)
            self.user = user
        } catch LoginError.wrongUser {
            print(LoginError.wrongUser.localizedDescription)
        } catch {
            print("Неизвестная ошибка")
        }
        self.statusBarFrame = statusBarFrame
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        statusBarView.frame = statusBarFrame
        view.addSubview(whiteView)
        view.addSubview(tableView)
        setConstraintsPVC()
        view.addSubview(statusBarView)
    }
    
}

// MARK: - Методы TableView

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0  {
            openPhotosCollectionVC()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: Identificators.header) as! ProfileHeaderView
            let gesture = UITapGestureRecognizer(target: self, action: #selector(avatarTapped))
            headerView.avatarImageView.addGestureRecognizer(gesture)
            headerView.statusTextField.delegate = self
            headerView.setStatusButton.onTap = {
                self.headerButtonPressed()
            }
            headerView.statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
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
            let cell = tableView.dequeueReusableCell(withIdentifier: Identificators.cellID2, for: indexPath) as! PhotosTableViewCell
//            let gesture = UITapGestureRecognizer(target: self, action: #selector(openPhotosCollectionVC))
//            cell.photoCollection.addGestureRecognizer(gesture)
            cell.coordinator = self.coordinator
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: Identificators.cellID, for: indexPath) as! PostTableViewCell
            cell.post = posts[indexPath.row]
            return cell
        }
    }
    
    @objc private func openPhotosCollectionVC() {
        coordinator?.showPhotosCollectionModule()
    }
    
// MARK: - Анимация StatusBar
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = -tableView.contentOffset.y
        UIView.animate(withDuration: 0.1, delay: 0) {
            if offsetY <= 14 {
                self.statusBarView.alpha = 1
            } else {
                self.statusBarView.alpha = 0
            }
        }
    }
    
}

// MARK: - Констрейнты
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

// MARK: - Кнопки для Header

extension ProfileViewController {
    
    private func headerButtonPressed() {
        guard let text = headerView.statusText else { return headerView.dismissKeyboardInView() }
        guard headerView.statusText != "" else { return headerView.dismissKeyboardInView() }
        headerView.statusLabel.text = text
        headerView.dismissKeyboardInView()
    }
    
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.headerButtonPressed()
        return true
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        headerView.statusText = textField.text
    }
    
}

// MARK: - Анимация

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
