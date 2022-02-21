//
//  Coordinator.swift
//  BrainUp
//
//  Created by Evgenii Zhigunov on 2/16/22.
//

import UIKit

protocol Coordinator: AnyObject {
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    var type: CoordinatorType { get }
    
    func start()
    func finish()
    init(_ navigationController: UINavigationController)
}

extension Coordinator {
    func finish() {
        childCoordinators.removeAll()
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
}

protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: Coordinator)
}

enum CoordinatorType: String {
    case app
    case login
    case tab
    case exersices = "tabBar.item.exersices"
    case statistics = "tabBar.item.statistics"
    case diagnostics = "tabBar.item.diagnostics"
    case profile = "tabBar.item.profile"
}
