//
//  YearsStatisticCoordinator.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 18/02/2022.
//

import UIKit

class YearsStatisticCoordinator: TopTabItemCoordinator {
    override func start() {
        let viewController = YearsStatisticViewController()
        viewController.view.backgroundColor = .blue
        addToContainer(controller: viewController)
    }
}
