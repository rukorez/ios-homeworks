//
//  FavoriteModuleFactory.swift
//  Navigation
//
//  Created by Филипп Степанов on 14.09.2022.
//

import Foundation
import UIKit

final class FavoriteModuleFactory: ModuleFactory {
    
    func makeFirstModule() -> UIViewController {
        makeFavoritePostsModule()
    }
    
    func makeFavoritePostsModule() -> FavoriteTableViewController {
        FavoriteTableViewController()
    }
   
}
