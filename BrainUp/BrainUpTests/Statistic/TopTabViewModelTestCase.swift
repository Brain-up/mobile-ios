//
//  TopTabViewModelTestCase.swift
//  BrainUpTests
//
//  Created by Andrei Trukhan on 26/11/2022.
//

import XCTest
@testable import BrainUp

final class TopTabViewModelTestCase: XCTestCase {
    func testInit() {
        var isTabTapped = false
        let viewModel = TopTabViewModel(title: "title", isActive: true) {
            isTabTapped = true
        }

        XCTAssertFalse(isTabTapped)
        XCTAssertTrue(viewModel.isActive)
        XCTAssertEqual(viewModel.title, "title")

        viewModel.tabTapped()
        XCTAssertTrue(isTabTapped)

        viewModel.updateState(isActive: false)
        XCTAssertFalse(viewModel.isActive)

        viewModel.updateState(isActive: true)
        XCTAssertTrue(viewModel.isActive)
    }
}
