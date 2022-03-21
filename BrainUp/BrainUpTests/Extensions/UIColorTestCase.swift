//
//  UiColorTestCase.swift
//  BrainUpTests
//
//  Created by Evgenii Zhigunov on 3/18/22.
//

import XCTest
@testable import BrainUp

class UIColorTestCase: XCTestCase {
    
    func testIsEquals() {
        let testColor1 = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        let testColor2 = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        XCTAssertEqual(testColor1, testColor2)
        XCTAssertTrue(testColor1 == testColor2)
    }
    
    func testIsNotEquals() {
        let testColor1 = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        let testColor2 = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        XCTAssertNotEqual(testColor1, testColor2)
        XCTAssertFalse(testColor1 == testColor2)
    }
    
    func testGetByName() {
        let testValidName = "activeGray"
        XCTAssertFalse((UIColor.getByName(testValidName) == UIColor.clear))
        let testNotValidName = "ActiveGray"
        XCTAssertTrue((UIColor.getByName(testNotValidName) == UIColor.clear))
    }
    
    func testActiveGray() {
        let testColor = UIColor(red: 109/255, green: 106/255, blue: 128/255, alpha: 1)
        XCTAssertTrue(testColor == UIColor.activeGray)
    }
    
    func testAlmostBlack() {
        let testColor = UIColor(red: 12/255, green: 11/255, blue: 16/255, alpha: 1)
        XCTAssertTrue(testColor == UIColor.almostBlack)
    }
    
    func testAppWhite() {
        let testColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        XCTAssertTrue(testColor == UIColor.appWhite)
    }
    
    func testBrainGreen() {
        let testColor = UIColor(red: 71/255, green: 205/255, blue: 138/255, alpha: 1)
        XCTAssertTrue(testColor == UIColor.brainGreen)
    }
    
    func testBrainPink() {
        let testColor = UIColor(red: 243/255, green: 134/255, blue: 152/255, alpha: 1)
        XCTAssertTrue(testColor == UIColor.brainPink)
    }
    
    func testButtonBorder() {
        let testColor = UIColor(red: 230/255, green: 228/255, blue: 240/255, alpha: 1)
        XCTAssertTrue(testColor == UIColor.buttonBorder)
    }
    
    func testCharcoalGray() {
        let testColor = UIColor(red: 61/255, green: 58/255, blue: 77/255, alpha: 1)
        XCTAssertTrue(testColor == UIColor.charcoalGrey)
    }
    
    func testColdViolet() {
        let testColor = UIColor(red: 121/255, green: 121/255, blue: 242/255, alpha: 1)
        XCTAssertTrue(testColor == UIColor.coldViolet)
    }
    
    func testDarkGreen() {
        let testColor = UIColor(red: 36/255, green: 178/255, blue: 108/255, alpha: 1)
        XCTAssertTrue(testColor == UIColor.darkGreen)
    }
    
    func testDarkViolet() {
        let testColor = UIColor(red: 80/255, green: 61/255, blue: 173/255, alpha: 1)
        XCTAssertTrue(testColor == UIColor.darkViolet)
    }
    
    func testHardlyGray() {
        let testColor = UIColor(red: 246/255, green: 245/255, blue: 252/255, alpha: 1)
        XCTAssertTrue(testColor == UIColor.hardlyGrey)
    }
    
    func testLatterGray() {
        let testColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
        XCTAssertTrue(testColor == UIColor.latterGrey)
    }
    
    func testLatteViolet() {
        let testColor = UIColor(red: 234/255, green: 230/255, blue: 254/255, alpha: 1)
        XCTAssertTrue(testColor == UIColor.latteViolet)
    }
    
    func testMouseGray() {
        let testColor = UIColor(red: 165/255, green: 162/255, blue: 184/255, alpha: 1)
        XCTAssertTrue(testColor == UIColor.mouseGrey)
    }
    
    func testShadowColor() {
        let testColor = UIColor(red: 89/255, green: 71/255, blue: 178/255, alpha: 1)
        XCTAssertTrue(testColor == UIColor.shadowColor)
    }
    
    func testWarmViolet() {
        let testColor = UIColor(red: 161/255, green: 121/255, blue: 242/255, alpha: 1)
        XCTAssertTrue(testColor == UIColor.warmViolet)
    }
}
