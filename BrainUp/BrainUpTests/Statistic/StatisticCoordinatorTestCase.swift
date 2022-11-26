//
//  StatisticCoordinator.swift
//  BrainUpTests
//
//  Created by Andrei Trukhan on 26/11/2022.
//

import XCTest
@testable import BrainUp

final class StatisticCoordinatorTestCase: XCTestCase {
    func testItemsTopViewModels() {
        let coordinator = StatisticsCoordinator(UINavigationController())
        let networkServiceMock = NetworkServiceMock(type: .week)
        coordinator.networkService = networkServiceMock

        coordinator.start()

//        coordinator.childCoordinators.first
    }
}
