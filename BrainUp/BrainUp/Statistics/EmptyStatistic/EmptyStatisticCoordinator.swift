//
//  EmptyStatisticCoordinator.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 18/02/2022.
//

import UIKit

class EmptyStatisticCoordinator: TopTabItemCoordinator {
    var startExercisesAction: (() -> Void)?

    override func start() {
        var viewModel = EmptyStatisticViewModel()
        viewModel.startExercisesButtonAction = startExercisesAction

        let viewController = EmptyStatisticViewController(viewModel: viewModel)
        addToContainer(controller: viewController)
    }
}
