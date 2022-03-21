//
//  AppCoordinator.swift
//  BrainUp
//
//  Created by Evgenii Zhigunov on 2/16/22.
//

import UIKit

class AppCoordinator: Coordinator {
    var finishDelegate: CoordinatorFinishDelegate?
    
    var type: CoordinatorType {.app}
    
    var childCoordinators: [Coordinator] = [Coordinator]()
    
    var navigationController: UINavigationController
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToAuth()
    }
    
    private func goToAuth() {
        let authCoordinator = AuthCoordinator(navigationController)
        childCoordinators.append(authCoordinator)
        authCoordinator.finishDelegate = self
        authCoordinator.start()
    }
    
    private func goToTabbar() {
        let tabCoordinator = TabBarCoordinator(navigationController)
        childCoordinators.append(tabCoordinator)
        tabCoordinator.finishDelegate = self
        tabCoordinator.start()
        navigationController.setNavigationBarHidden(true, animated: true)
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter({$0.type != childCoordinator.type})
        switch childCoordinator.type {
        case .login:
            navigationController.viewControllers.removeAll()
            goToTabbar()
        case .tab:
            navigationController.viewControllers.removeAll()
            goToAuth()
        default:
            break
        }
    }
    
}
