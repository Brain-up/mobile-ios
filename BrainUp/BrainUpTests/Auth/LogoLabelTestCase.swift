//
//  LogoLabelTestCase.swift
//  BrainUpTests
//
//  Created by Evgenii Zhigunov on 3/18/22.
//

import XCTest
import UIKit
@testable import BrainUp

class LogoLabelTestCase: XCTestCase {

    func testLabelText() {
        let label = LogoLabel()
        XCTAssertEqual("BrainUp", label.text)
    }
}
