//
//  AnyCoordinator.swift
//  BrainUpTests
//
//  Created by Andrei Trukhan on 24/11/2022.
//

import UIKit
@testable import BrainUp

class AnyCoordinator: Coordinator {
    var finishDelegate: BrainUp.CoordinatorFinishDelegate?
    var childCoordinators: [BrainUp.Coordinator] = []
    var navigationController: UINavigationController
    var type: BrainUp.CoordinatorType = .diagnostics
    
    func start() {}
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    init(type: BrainUp.CoordinatorType) {
        self.navigationController = UINavigationController()
        self.type = type
    }
}

class CoordinatorFinishDelegateSpy: CoordinatorFinishDelegate {
    var childCoordinatorType: CoordinatorType?

    func coordinatorDidFinish(childCoordinator: BrainUp.Coordinator) {
        childCoordinatorType = childCoordinator.type
    }
}
