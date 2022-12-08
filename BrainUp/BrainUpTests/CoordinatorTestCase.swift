//
//  CoordinatorTestCase.swift
//  BrainUpTests
//
//  Created by Andrei Trukhan on 24/11/2022.
//

import XCTest
@testable import BrainUp

final class CoordinatorTestCase: XCTestCase {
    func testFinish() {
        let parentCoordinator = AnyCoordinator(type: .app)
        let childCoordinator = AnyCoordinator(type: .diagnostics)

        let coordinatorFinishDelegateSpy = CoordinatorFinishDelegateSpy()
        childCoordinator.finishDelegate = coordinatorFinishDelegateSpy
        parentCoordinator.finishDelegate = coordinatorFinishDelegateSpy

        XCTAssertEqual(childCoordinator.childCoordinators.count, 0)

        childCoordinator.finish()
        XCTAssertEqual(coordinatorFinishDelegateSpy.childCoordinatorType, .diagnostics)

        parentCoordinator.childCoordinators.append(childCoordinator)

        XCTAssertEqual(parentCoordinator.childCoordinators.count, 1)
        parentCoordinator.finish()

        XCTAssertEqual(parentCoordinator.childCoordinators.count, 0)
        XCTAssertEqual(coordinatorFinishDelegateSpy.childCoordinatorType, .app)
    }
}
