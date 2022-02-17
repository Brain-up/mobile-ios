//
//  ProfileCoordinator.swift
//  BrainUp
//
//  Created by Evgenii Zhigunov on 2/17/22.
//

import Foundation
import UIKit

class ProfileCoordinator: Coordinator {
    var finishDelegate: CoordinatorFinishDelegate?
    
    var childCoordinators: [Coordinator] = [Coordinator]()
    
    var navigationController: UINavigationController
    
    var type: CoordinatorType {.profile}
    
    func start() {
        
    }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
}
