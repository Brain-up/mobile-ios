//
//  WeeksStatisticCoordinator.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 18/02/2022.
//

import UIKit

class WeeksStatisticCoordinator: TopTabItemCoordinator {
    override func start() {
        let viewController = WeeksStatisticViewController()
        viewController.view.backgroundColor = .green
        addToContainer(controller: viewController)
    }
}
