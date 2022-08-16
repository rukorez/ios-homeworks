//
//  PlayerModuleFactory.swift
//  Navigation
//
//  Created by Филипп Степанов on 07.08.2022.
//

import UIKit

final class PlayerModuleFactory: ModuleFactory {
    
    func makeFirstModule() -> UIViewController {
        makePlayerModule()
    }
    
    func makePlayerModule() -> PlayerViewController {
        return PlayerViewController()
    }
}

