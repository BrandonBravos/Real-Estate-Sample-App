//
//  MainCoordinator.swift
//  Re Max Sample App
//
//  Created by Brandon Bravos on 11/13/22.
//

import Foundation
import UIKit

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate{
 
    var childCoodinators: [Coordinator]?
    var navigationController: UINavigationController
    
    let initialViewController = HomeFeedViewController()
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
        self.navigationController.isNavigationBarHidden = true
    }
    
    func eventOccured(with type: CoordinatorEvent) {
        switch type{
            case .propertyPreviewController:
                pushViewController(withView: HousePreviewViewController())
            case .homeViewController:
                navigationController.popToRootViewController(animated: true)
        }
    }
    
    func pushHousePreviewController(property: HouseObject){
        let vc =  HousePreviewViewController()
        vc.houseObject = property
        pushViewController(withView: vc)

    }
    
    
    func start() {
       navigationController.delegate = self
       pushViewController(withView: initialViewController)
        
        
    }
    
    /// Pushes View Controller using our Coordinators Navigation Controller. View controller must conform to Cootdinating
    func pushViewController(withView view: UIViewController & Coordinating){
        var viewController = view
        viewController.coordinatinor = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        if navigationController.viewControllers.contains(fromViewController){
            return
        }
    }
    
    
}
