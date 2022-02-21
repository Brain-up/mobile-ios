//
//  EmptyStatisticCoordinatorTestCase.swift
//  BrainUpTests
//
//  Created by Andrei Trukhan on 18/02/2022.
//

import XCTest
@testable import BrainUp

class EmptyStatisticCoordinatorTestCase: XCTestCase {

    func testStart() {
        let controller = UIViewController()
        let coordinator = EmptyStatisticCoordinator(rootViewController: controller, containerView: controller.view)

        XCTAssertEqual(controller.view.subviews.count, 0)
        XCTAssertEqual(controller.children.count, 0)
        coordinator.start()

        XCTAssertEqual(controller.view.subviews.count, 1, "EmptyStatistic controller view is not added to rootController view")

        XCTAssertEqual(controller.children.count, 1, "EmptyStatistic controller is not added to rootController")
    }

    func testStartExercisesAction() {
        let controller = UIViewController()
        let coordinator = EmptyStatisticCoordinator(rootViewController: controller, containerView: controller.view)
        let exp = expectation(description: "Wait for Action")

        coordinator.startExercisesAction = {
            exp.fulfill()
        }

        coordinator.start()

        guard let childController = controller.children.first as? EmptyStatisticViewController else {
            XCTFail("EmptyStatisticCoordinator doesn't create EmptyStatisticViewController")
            return
        }
        
        childController.startExercisesButtonClicked()
        
        wait(for: [exp], timeout: 1)
    }
}
