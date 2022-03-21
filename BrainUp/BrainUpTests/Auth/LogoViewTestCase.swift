//
//  LogoViewTestCase.swift
//  BrainUpTests
//
//  Created by Evgenii Zhigunov on 3/18/22.
//

import XCTest
import UIKit
@testable import BrainUp

class LogoViewTestCase: XCTestCase {

    func testInitFrame() {
        let view = LogoView(frame: .zero)
        XCTAssertNotNil(view)
        XCTAssertEqual(view.subviews.count, 2)
    }
}
