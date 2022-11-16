//
//  Coordinator.swift
//  Re Max Sample App
//
//  Created by Brandon Bravos on 11/13/22.
//

import Foundation
import UIKit

enum CoordinatorEvent{
    case propertyPreviewController
    case homeViewController
}


protocol Coordinator: AnyObject{
    var childCoodinators: [Coordinator]? {get set}
    var navigationController: UINavigationController {get set}
    
    func eventOccured(with type: CoordinatorEvent)
    func start()
    
}

// view controller needs reference to coordinator to relay events
protocol Coordinating {
     var coordinatinor: Coordinator? {get set}
    
}
