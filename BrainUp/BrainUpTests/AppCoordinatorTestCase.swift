//
//  AppCoordinatorTestCase.swift
//  BrainUpTests
//
//  Created by Andrei Trukhan on 24/11/2022.
//

import XCTest
@testable import BrainUp

final class AppCoordinatorTestCase: XCTestCase {
    func testInit() {
        let appCoordinator = AppCoordinator(UINavigationController())
        XCTAssertEqual(appCoordinator.type, .app)
    }

    func testOpenAuthAfterStart() {
        let appCoordinator = AppCoordinator(UINavigationController())

        appCoordinator.start()
        XCTAssertEqual(appCoordinator.childCoordinators.count, 1)
        XCTAssertEqual(appCoordinator.childCoordinators.first?.type, .login)
    }

    func testOpenTabBarAfterAuth() {
        let appCoordinator = AppCoordinator(UINavigationController())

        appCoordinator.start()
        let authCoordinator = appCoordinator.childCoordinators.first
        authCoordinator?.finish()

        XCTAssertEqual(appCoordinator.childCoordinators.count, 1)
        XCTAssertEqual(appCoordinator.childCoordinators.first?.type, .tab)
    }

    func testOpenAuthAfterTabBar() {
        let appCoordinator = AppCoordinator(UINavigationController())

        appCoordinator.start()
        let authCoordinator = appCoordinator.childCoordinators.first
        authCoordinator?.finish()

        let tabCoordinator = appCoordinator.childCoordinators.first
        tabCoordinator?.finish()

        XCTAssertEqual(appCoordinator.childCoordinators.count, 1)
        XCTAssertEqual(appCoordinator.childCoordinators.first?.type, .login)
    }
}
