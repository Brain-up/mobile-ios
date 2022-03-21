//
//  TokenTestCase.swift
//  BrainUpTests
//
//  Created by Evgenii Zhigunov on 3/14/22.
//

import XCTest
@testable import BrainUp

class TokenProtocolTestCase: XCTestCase {
    var token: TokenProtocol = TokenMock()
    let testToken = "123"
    
    func testSaveToken() {
        token = TokenMock()
        XCTAssertTrue(token.isEmpty())
        token.save(testToken)
        XCTAssertFalse(token.isEmpty())
    }
    
    func testRejectToken() {
        token = TokenMock()
        XCTAssertTrue(token.isEmpty())
        token.save(testToken)
        XCTAssertFalse(token.isEmpty())
        token.reject()
        XCTAssertTrue(token.isEmpty())
    }
    
    func testGetToken() {
        token = TokenMock()
        XCTAssertTrue(token.isEmpty())
        token.save(testToken)
        XCTAssertFalse(token.isEmpty())
        XCTAssertEqual(testToken, token.getToken())
    }
}
