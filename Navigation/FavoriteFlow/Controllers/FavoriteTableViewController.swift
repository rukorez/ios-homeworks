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
        let post = CoreDataPostModel.defaultModel.posts[indexPath.row]
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

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataPostModel.defaultModel.posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = CoreDataPostModel.defaultModel.posts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! FavoritePostTableViewCell
        cell.post = post
        return cell
    }

}
