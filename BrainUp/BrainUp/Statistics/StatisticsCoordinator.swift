//
//  StatisticsCoordinator.swift
//  BrainUp
//
//  Created by Evgenii Zhigunov on 2/17/22.
//

import Foundation
import UIKit

class StatisticsCoordinator: Coordinator {
    var finishDelegate: CoordinatorFinishDelegate?
    
    var childCoordinators: [Coordinator] = [Coordinator]()
    
    var navigationController: UINavigationController
    
    var type: CoordinatorType {.statistics}
    
    func start() {
        
    }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
}
