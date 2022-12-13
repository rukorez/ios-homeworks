//
//  ModuleFactoryProtocol.swift
//  Navigation
//
//  Created by Филипп Степанов on 13.05.2022.
//

import Foundation
import UIKit

protocol ModuleFactory: AnyObject  {
    func makeFirstModule() -> UIViewController
}
