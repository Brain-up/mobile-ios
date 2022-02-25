//
//  YearsStatisticCoordinator.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 18/02/2022.
//

import UIKit

class YearsStatisticCoordinator: TopTabItemCoordinator {
    private let networkService: NetworkService
    // property injection for test purpose. If we consider separate architecture in modules, we could inject this properties inside init method.
    var mapper = StatisticYearItemsMapper()
    var helper: StatisticDateHelperProtocol.Type = StatisticDateHelper.self

    init(rootViewController: UIViewController, containerView: UIView, networkService: NetworkService) {
        self.networkService = networkService
        super.init(rootViewController: rootViewController, containerView: containerView)
    }

    required init(_ navigationController: UINavigationController) {
        preconditionFailure("init(_:) has not been implemented")
    }

    override func start() {
        let viewController = YearsStatisticViewController()
        viewController.view.backgroundColor = .blue
        addToContainer(controller: viewController)
    }
}
