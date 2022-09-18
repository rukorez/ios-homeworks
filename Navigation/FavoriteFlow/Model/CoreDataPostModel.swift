//
//  CoreDataPostModel.swift
//  Navigation
//
//  Created by Филипп Степанов on 14.09.2022.
//

import Foundation
import CoreData
import StorageDevice

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
    
    private lazy var mainContext: NSManagedObjectContext = {
        var context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        return context
    }()
    
    private lazy var backgroundContext: NSManagedObjectContext = {
        var context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        return context
    }()

    // MARK: - Core Data Saving support

    private func saveMainContext() {
        if mainContext.hasChanges {
            do {
                try mainContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    private func saveBackgroundContext() {
        if backgroundContext.hasChanges {
            do {
                try backgroundContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension CoreDataPostModel {
    
    func addPost(post: Posts) {
        let newPost = CoreDataPost(context: backgroundContext)
        newPost.author = post.author
        newPost.postDescription = post.description
        newPost.likes = Int64(post.likes)
        newPost.views = Int64(post.views)
        newPost.added_at = Date()
        newPost.imageData = post.image.jpegData(compressionQuality: 1.0)
        saveBackgroundContext()
        reloadPosts()
    }
    
    func deletePost(post: Posts) -> Bool {
        var bool = false
        posts.forEach {
            if $0.postDescription == post.description {
                backgroundContext.delete($0)
                saveBackgroundContext()
                reloadPosts()
                bool = true
            }
        }
        return bool
    }
    
    func deletePost(post: CoreDataPost) {
        backgroundContext.delete(post)
        saveBackgroundContext()
        reloadPosts()
    }
    
    func reloadPosts() {
        let request = CoreDataPost.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "added_at", ascending: false)]
        do {
            let posts = try backgroundContext.fetch(request)
            self.posts = posts
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func searchPost(author text: String) -> [CoreDataPost] {
        let request = CoreDataPost.fetchRequest()
        request.predicate = NSPredicate(format: "author contains[c] %@", text)
        request.sortDescriptors = [NSSortDescriptor(key: "added_at", ascending: false)]
        do {
            let posts = try backgroundContext.fetch(request)
            return posts
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
}
