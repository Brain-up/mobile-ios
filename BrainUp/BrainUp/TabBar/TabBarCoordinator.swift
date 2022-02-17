//
//  TabBarCoordinator.swift
//  BrainUp
//
//  Created by Evgenii Zhigunov on 2/16/22.
//

import Foundation
import UIKit

protocol TabCoordinatorProtocol: Coordinator {
    var tabBarController: UITabBarController { get set }
    
    func selectPage(_ page: TabBarPage)
    
    func setSelectedIndex(_ index: Int)
    
    func currentPage() -> TabBarPage?
}

class TabBarCoordinator: TabCoordinatorProtocol {
    var tabBarController: UITabBarController
        
    var finishDelegate: CoordinatorFinishDelegate?
    
    var childCoordinators: [Coordinator] = [Coordinator]()
    
    var navigationController: UINavigationController
    
    var type: CoordinatorType {.tab}
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = AppTabbarController()// .init()
    }
    
    func start() {
        let pages: [TabBarPage] = TabBarPage.allCases.sorted(by: {$0.pageOrderNumber() < $1.pageOrderNumber()})
        let controllers: [UINavigationController] = pages.map({getController($0)})
        prepareTabBarController(withTabControllers: controllers)
        /*
         пройти по всем вкладкам, создать координаторы, на вход новые навбары. по методу старт - создаем нужные вц. забираем у координатора навбар и вставляем в таббар
         */
    }
    
    func selectPage(_ page: TabBarPage) {
        
    }
    
    func setSelectedIndex(_ index: Int) {
        
    }
    
    func currentPage() -> TabBarPage? {
        return nil
    }
    
    private func getController(_ page: TabBarPage) -> UINavigationController {
        let navController = UINavigationController()
        navController.setNavigationBarHidden(false, animated: false)
        let tabbarItem = UITabBarItem.init(title: nil, image: page.getTabIcon(), tag: page.pageOrderNumber())
        navController.tabBarItem = tabbarItem
        let coordinator = page.getCoordinator().init(navController)
        childCoordinators.append(coordinator)
        return childCoordinators.last?.navigationController ?? UINavigationController()
    }
    
    private func prepareTabBarController(withTabControllers tabControllers: [UINavigationController]) {
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.selectedIndex = TabBarPage.exercises.pageOrderNumber()
        navigationController.viewControllers = [tabBarController]
    }
}
