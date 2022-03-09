//
//  AuthCoordinator.swift
//  BrainUp
//
//  Created by Evgenii Zhigunov on 2/16/22.
//

import Foundation
import UIKit

protocol SplashDelegate: AnyObject {
    func onUserAuthorized()
    func onUserUnauthorized()
}

class AuthCoordinator: Coordinator {
    var finishDelegate: CoordinatorFinishDelegate?
    
    var type: CoordinatorType {.login}
    
    var childCoordinators: [Coordinator] = [Coordinator]()
    
    var navigationController: UINavigationController
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        self.goToSplash()
    }
    
    private func goToAuth() {
        let loginVC = AuthVC()
        let model = AuthVM(view: loginVC)
        loginVC.model = model
        navigationController.setViewControllers([loginVC], animated: true)
    }
    
    private func goToSplash() {
        let splashVC = SplashVC()
        let model  = SplashVM(delegate: self)
        splashVC.model = model
        navigationController.setViewControllers([splashVC], animated: true)
    }
}

extension AuthCoordinator: SplashDelegate {
    
    func onUserAuthorized() {
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
    
    func onUserUnauthorized() {
        self.goToAuth()
    }
}
