//
//  MapModuleFactory.swift
//  Navigation
//
//  Created by Филипп Степанов on 10.11.2022.
//

import Foundation
import UIKit

final class MapModuleFactory: ModuleFactory {
    
    func makeFirstModule() -> UIViewController {
        makeMapModule()
    }
    
    func makeMapModule() -> MapViewController {
        MapViewController()
    }
   
}
