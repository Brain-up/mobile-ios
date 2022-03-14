//
//  BaseVCTestCase.swift
//  BrainUpTests
//
//  Created by Evgenii Zhigunov on 3/14/22.
//

import XCTest
@testable import BrainUp

class BaseVCTestCase: XCTestCase {
    var basicVC: BasicVCMock = BasicVCMock()
    
    func testDidntShowAnithingOnStart() {
        XCTAssertFalse(basicVC.isLoading)
        XCTAssertFalse(basicVC.isShowingError)
        XCTAssertEqual(basicVC.errorMessage, "")
    }
    
    func testShowLoading() {
        basicVC.showLoading()
        XCTAssertTrue(basicVC.isLoading)
        XCTAssertFalse(basicVC.isShowingError)
        XCTAssertEqual(basicVC.errorMessage, "")
    }
    
    func testHideLoading() {
        basicVC.hideLoading()
        XCTAssertFalse(basicVC.isLoading)
        XCTAssertFalse(basicVC.isShowingError)
        XCTAssertEqual(basicVC.errorMessage, "")
    }
    
    func testShowError() {
        let testErroroMessage: String = "Test Error Message"
        basicVC.showError(errorMessage: testErroroMessage)
        XCTAssertFalse(basicVC.isLoading)
        XCTAssertTrue(basicVC.isShowingError)
        XCTAssertEqual(testErroroMessage, basicVC.errorMessage)
    }
    
    func testHideError() {
        basicVC.hideError()
        XCTAssertFalse(basicVC.isLoading)
        XCTAssertFalse(basicVC.isShowingError)
        XCTAssertEqual(basicVC.errorMessage, "")
    }
}
