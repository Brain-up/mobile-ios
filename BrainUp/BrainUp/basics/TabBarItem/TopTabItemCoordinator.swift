//
//  BrainUpTopTabItemCoordinator.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 17/02/2022.
//

import UIKit

/// Abstract class with default init and general setup of finish func.
/// This class provides addToContainer(controller: UIViewController) function which adds your ViewController to containerView
/// Don't forget to call addToContainer(controller: UIViewController) function in subClass start method
class TopTabItemCoordinator: Coordinator {
    func start() { }
    
    var finishDelegate: CoordinatorFinishDelegate?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController = UINavigationController()
    
    var type: CoordinatorType { .statistics } // ??
    
    required init(_ navigationController: UINavigationController) {
        preconditionFailure("We couldn't use here this initializer")
    }
    
    private let rootViewController: UIViewController
    private let containerView: UIView
    private(set) var topTabItemController: UIViewController?
    
    /// Default initializer
    /// - Parameters:
    ///   - rootViewController: ViewController that will show your embedded viewController
    ///   - containerView: View inside wich your embedded viewController will be located
    init(rootViewController: UIViewController, containerView: UIView) {
        self.rootViewController = rootViewController
        self.containerView = containerView
    }
    
    /// Adds your controller to containerView of rootViewController with all needed setup
    /// - Parameter controller: Controller wich should be presented inside rootViewController containerView
    func addToContainer(controller: UIViewController) {
        rootViewController.addChild(controller)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(controller.view)

        NSLayoutConstraint.activate([
            controller.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            controller.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            controller.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            controller.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])

        controller.didMove(toParent: rootViewController)
        topTabItemController = controller
    }

    func finish() {
        topTabItemController?.willMove(toParent: nil)
        topTabItemController?.view.removeFromSuperview()
        topTabItemController?.removeFromParent()
    }
}
