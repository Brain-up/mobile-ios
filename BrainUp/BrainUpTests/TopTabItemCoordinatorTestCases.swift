//
//  TopTabItemCoordinatorTestCases.swift
//  BrainUpTests
//
//  Created by Andrei Trukhan on 18/02/2022.
//

import XCTest
@testable import BrainUp

class TestViewController: UIViewController {}

class TopTabItemCoordinatorTestCases: XCTestCase {
    
    func testAddToContainer() {
        let controller = UIViewController()
        let innerController = TestViewController()
        let coordinator = TopTabItemCoordinator(rootViewController: controller, containerView: controller.view)

        XCTAssertEqual(controller.view.subviews.count, 0)
        XCTAssertEqual(controller.children.count, 0)

        coordinator.addToContainer(controller: innerController)

        XCTAssertEqual(controller.view.subviews.count, 1, "TopTabItemCoordinator is not add controller view into rootController view")

        XCTAssertEqual(controller.children.count, 1, "TopTabItemCoordinator is not add controller into rootController")
        let capturedVC = controller.children.first as? TestViewController
        XCTAssertNotNil(capturedVC, "TopTabItemCoordinator adds not the same vc to rootVC than getted")
    }

    func testFinish() {
        let controller = UIViewController()
        let innerController = TestViewController()
        let coordinator = TopTabItemCoordinator(rootViewController: controller, containerView: controller.view)
        
        coordinator.addToContainer(controller: innerController)
        coordinator.finish()

        XCTAssertEqual(controller.view.subviews.count, 0, "EmptyStatistic controller view is not remove to rootController view")

        XCTAssertEqual(controller.children.count, 0, "TopTabItemCoordinator is not remove controller into rootController")
    }
}
