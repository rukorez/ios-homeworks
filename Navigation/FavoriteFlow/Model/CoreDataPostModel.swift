//
//  CoreDataPostModel.swift
//  Navigation
//
//  Created by Филипп Степанов on 14.09.2022.
//

import Foundation
import CoreData
import StorageDevice
//import UIKit

final class CoreDataPostModel {
    
    static let defaultModel = CoreDataPostModel()
    
    init() {
        reloadPosts()
    }
    
    var posts: [CoreDataPost] = []
    
    // MARK: - Core Data stack
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Navigation")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    private func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension CoreDataPostModel {
    
    func addPost(post: Posts) {
        let newPost = CoreDataPost(context: persistentContainer.viewContext)
        newPost.author = post.author
        newPost.postDescription = post.description
        newPost.likes = Int64(post.likes)
        newPost.views = Int64(post.views)
        newPost.added_at = Date()
        newPost.imageData = post.image.jpegData(compressionQuality: 1.0)
        saveContext()
        reloadPosts()
    }
    
    func deletePost(post: Posts) -> Bool {
        var bool = false
        posts.forEach {
            if $0.postDescription == post.description {
                persistentContainer.viewContext.delete($0)
                saveContext()
                reloadPosts()
                bool = true
            }
        }
        return bool
    }
    
    func deletePost(post: CoreDataPost) {
        persistentContainer.viewContext.delete(post)
        saveContext()
        reloadPosts()
    }
    
    func reloadPosts() {
        let request = CoreDataPost.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "added_at", ascending: false)]
        do {
            let posts = try persistentContainer.viewContext.fetch(request)
            self.posts = posts
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
