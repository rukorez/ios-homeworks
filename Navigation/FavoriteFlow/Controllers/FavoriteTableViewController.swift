//
//  FavoriteTableViewController.swift
//  Navigation
//
//  Created by Филипп Степанов on 14.09.2022.
//

import UIKit
import StorageDevice

class FavoriteTableViewController: UITableViewController {
    
    var coordinator: Coordinator?
    
    var favoritePosts: [CoreDataPost] = CoreDataPostModel.defaultModel.posts {
        didSet {
            tableView.reloadData()
        }
    }
    
    private lazy var likeImage: UIImageView = {
        var image = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 90))
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.backgroundColor = .systemGray6
        image.tintColor = .systemBlue
        image.alpha = 0
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setTableViewSettings()
        setDTGR()
        setBarButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    private func setTableViewSettings() {
        tableView.register(FavoritePostTableViewCell.self, forCellReuseIdentifier: "postCell")
        view.addSubview(likeImage)
    }
    
    private func setDTGR() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(doupleTap(_:)))
        gesture.numberOfTapsRequired = 2
        tableView.addGestureRecognizer(gesture)
    }
    
    @objc private func doupleTap(_ gesture: UITapGestureRecognizer) {
        let position = gesture.location(in: tableView)
        guard let indexPath = tableView.indexPathForRow(at: position) else {
            tableView.reloadData()
            return
        }
        let post = favoritePosts[indexPath.row]
        unLikeAnimation()
        CoreDataPostModel.defaultModel.deletePost(post: post)
        tableView.reloadData()
    }
    
    private func unLikeAnimation() {
        likeImage.center.x = tableView.center.x
        likeImage.center.y = tableView.center.y - 100
        UIView.animate(withDuration: 1) {
            self.likeImage.image = UIImage(systemName: "heart.slash.fill")
            self.likeImage.alpha = 0.8
        } completion: { bool in
            UIView.animate(withDuration: 1) {
                self.likeImage.alpha = 0
            }
        }
    }
    
    private func setBarButtons() {
        let filterButton = UIBarButtonItem(title: "Поиск", style: .plain, target: self, action: #selector(filterByAuthor))
        let clearButton = UIBarButtonItem(title: "Сбросить", style: .done, target: self, action: #selector(clearFilter))
//        navigationItem.setRightBarButton(filterButton, animated: true)
        navigationItem.setRightBarButtonItems([clearButton, filterButton], animated: true)
    }
    
    @objc func filterByAuthor() {
        let searchAlert = UIAlertController(title: "Поиск по автору", message: nil, preferredStyle: .alert)
        searchAlert.addTextField()
        let actionOk = UIAlertAction(title: "Применить", style: .default) { action in
            guard let text = searchAlert.textFields?[0].text, text != "" else { return }
            self.favoritePosts = CoreDataPostModel.defaultModel.searchPost(author: text)
        }
        let cancel = UIAlertAction(title: "Отмена", style: .cancel)
        searchAlert.addAction(cancel)
        searchAlert.addAction(actionOk)
        present(searchAlert, animated: true)
    }
    
    @objc func clearFilter() {
        self.favoritePosts = CoreDataPostModel.defaultModel.posts
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritePosts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = favoritePosts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! FavoritePostTableViewCell
        cell.post = post
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let post = favoritePosts[indexPath.row]
        let action = UIContextualAction(style: .destructive, title: "Удалить") { action, view, bool in
            self.unLikeAnimation()
            CoreDataPostModel.defaultModel.deletePost(post: post)
            self.tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }

}
