//
//  TokenTestCase.swift
//  BrainUpTests
//
//  Created by Evgenii Zhigunov on 3/14/22.
//

import XCTest
@testable import BrainUp

class TokenTestCase: XCTestCase {
    var token: TokenProtocol = Token.shared
    let testToken = "123"
    
    func testSaveToken() {
        token.reject()
        XCTAssertTrue(token.isEmpty())
        token.save(testToken)
        XCTAssertFalse(token.isEmpty())
    }
    
    func testRejectToken() {
        token.reject()
        XCTAssertTrue(token.isEmpty())
        token.save(testToken)
        XCTAssertFalse(token.isEmpty())
        token.reject()
        XCTAssertTrue(token.isEmpty())
    }
    
    func testGetToken() {
        token.reject()
        XCTAssertTrue(token.isEmpty())
        token.save(testToken)
        XCTAssertFalse(token.isEmpty())
        XCTAssertEqual(testToken, token.getToken())
    }
}
