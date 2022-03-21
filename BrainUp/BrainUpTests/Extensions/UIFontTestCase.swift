//
//  UIFontTestCase.swift
//  BrainUpTests
//
//  Created by Evgenii Zhigunov on 3/18/22.
//

import XCTest
@testable import BrainUp

class UIFontTestCase: XCTestCase {
    private let testFontSize: CGFloat = 12

    func testMontserratRegular() {
        let fontName = "Montserrat-Regular"
        guard let testFont = UIFont(name: fontName, size: testFontSize) else {
            XCTFail("Font \(fontName) not found")
            return
        }
        XCTAssertEqual(testFont, UIFont.montserratRegular(size: testFontSize))
    }
    
    func testMontserratBold() {
        let fontName = "Montserrat-Regular"
        guard let testFont = UIFont(name: fontName, size: testFontSize) else {
            XCTFail("Font \(fontName) not found")
            return
        }
        XCTAssertEqual(testFont, UIFont.montserratBold(size: testFontSize))
    }
    
    func testMontserratSemiBold() {
        let fontName = "Montserrat-Regular"
        guard let testFont = UIFont(name: fontName, size: testFontSize) else {
            XCTFail("Font \(fontName) not found")
            return
        }
        XCTAssertEqual(testFont, UIFont.montserratSemiBold(size: testFontSize))
    }
    
    func testOpenSansRegular() {
        let fontName = "OpenSans-Regular"
        guard let testFont = UIFont(name: fontName, size: testFontSize) else {
            XCTFail("Font \(fontName) not found")
            return
        }
        XCTAssertEqual(testFont, UIFont.openSansRegular(size: testFontSize))
    }
    
    func testReenieBeanie() {
        let fontName = "ReenieBeanie"
        guard let testFont = UIFont(name: fontName, size: testFontSize) else {
            XCTFail("Font \(fontName) not found")
            return
        }
        XCTAssertEqual(testFont, UIFont.reenieBeanie(size: testFontSize))
    }
}
