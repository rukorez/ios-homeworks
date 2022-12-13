//
//  FavoriteTableViewController.swift
//  Navigation
//
//  Created by Филипп Степанов on 14.09.2022.
//

import UIKit
import StorageDevice
import CoreData

class FavoriteTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var coordinator: Coordinator?
    
    private lazy var colors = ProfileViewColors()
    
    var fetchedResultsController: NSFetchedResultsController<CoreDataPost>?
        
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
        initFetchedResultsController(text: nil)
        setDTGR()
        setBarButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    private func setTableViewSettings() {
        tableView.backgroundColor = colors.tableViewBackgroundColor
        tableView.register(FavoritePostTableViewCell.self, forCellReuseIdentifier: "postCell")
        view.addSubview(likeImage)
    }
    
    private func initFetchedResultsController(text forPredicate: String?) {
        let request = CoreDataPost.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "added_at", ascending: false)]
        if let text = forPredicate {
            request.predicate = NSPredicate(format: "author contains[c] %@", text)
        }
        let context = CoreDataPostModel.defaultModel.persistentContainer.viewContext
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try frc.performFetch()
        } catch {
            print(error)
        }
        fetchedResultsController = frc
        fetchedResultsController?.delegate = self
        tableView.reloadData()
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
        guard let post = fetchedResultsController?.object(at: indexPath) else { return }
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
        let filterButton = UIBarButtonItem(title: NSLocalizedString("favoriteViewFilterButtonTitle", comment: ""), style: .plain, target: self, action: #selector(filterByAuthor))
        let clearButton = UIBarButtonItem(title: NSLocalizedString("favoriteViewClearButtonTitle", comment: ""), style: .done, target: self, action: #selector(clearFilter))
        navigationItem.setRightBarButtonItems([clearButton, filterButton], animated: true)
    }
    
    @objc func filterByAuthor() {
        let searchAlert = UIAlertController(title: NSLocalizedString("favoriteViewFilterAlertTitle", comment: ""), message: nil, preferredStyle: .alert)
        searchAlert.addTextField()
        let actionOk = UIAlertAction(title: NSLocalizedString("favoriteViewFilterAlertActionYes", comment: ""), style: .default) { action in
            guard let text = searchAlert.textFields?[0].text, text != "" else { return }
            self.initFetchedResultsController(text: text)
        }
        let cancel = UIAlertAction(title: NSLocalizedString("favoriteViewFilterAlertActionNo", comment: ""), style: .cancel)
        searchAlert.addAction(cancel)
        searchAlert.addAction(actionOk)
        present(searchAlert, animated: true)
    }
    
    @objc func clearFilter() {
        initFetchedResultsController(text: nil)
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        case .update:
            guard let indexPath = indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        case .move:
            guard let indexPath = indexPath, let newIndexPath = newIndexPath else { return }
            tableView.moveRow(at: indexPath, to: newIndexPath)
        @unknown default:
            print("Fatal Error")
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController?.sections?[section].numberOfObjects ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = fetchedResultsController?.object(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! FavoritePostTableViewCell
        cell.post = post
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let post = fetchedResultsController?.object(at: indexPath)
        let action = UIContextualAction(style: .destructive, title: NSLocalizedString("favoriteViewDeleteButtonTitle", comment: "")) { action, view, bool in
            guard let post = post else { return }
            self.unLikeAnimation()
            CoreDataPostModel.defaultModel.deletePost(post: post)
        }
        return UISwipeActionsConfiguration(actions: [action])
    }

}
