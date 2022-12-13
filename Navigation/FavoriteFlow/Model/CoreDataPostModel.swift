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
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Navigation")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    private lazy var backgroundContext: NSManagedObjectContext = {
        var context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        return context
    }()

    // MARK: - Core Data Saving support

    private func saveContext() {
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
        persistentContainer.performBackgroundTask { context in
            let newPost = CoreDataPost(context: context)
            newPost.author = post.author
            newPost.postDescription = post.description
            newPost.likes = Int64(post.likes)
            newPost.views = Int64(post.views)
            newPost.added_at = Date()
            newPost.imageData = post.image.jpegData(compressionQuality: 1.0)
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func deletePost(post: Posts) {
        let request = CoreDataPost.fetchRequest()
        request.predicate = NSPredicate(format: "postDescription == %@", post.description)
        do {
            guard let cdPost = try persistentContainer.viewContext.fetch(request).first else { return }
            persistentContainer.viewContext.delete(cdPost)
            saveContext()
        } catch {
            print(error)
        }
    }
    
    func deletePost(post: CoreDataPost) {
        persistentContainer.viewContext.delete(post)
        saveContext()
    }
    
    func checkPost(post: Posts) -> Bool? {
        let request = CoreDataPost.fetchRequest()
        let posts = try? persistentContainer.viewContext.fetch(request)
        guard let posts = posts else { return nil }
        if posts.isEmpty {
            return nil
        }
        if posts.contains(where: { $0.postDescription == post.description }) {
            return true
        } else {
            return false
        }
    }
    
}
