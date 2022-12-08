//
//  RequestTestCase.swift
//  BrainUpTests
//
//  Created by Evgenii Zhigunov on 3/18/22.
//

import XCTest
@testable import BrainUp

class RequestTestCase: XCTestCase {

    func testEmptyHeaders() {
        let testEmptyHeaders = [String: String]()
        let requestMock: Request = RequestMock()
        
        XCTAssertEqual(testEmptyHeaders, requestMock.headers)
    }
    
    func testEmptyParameters() {
        let requestMock: Request = RequestMock()
        
        XCTAssertNil(requestMock.parameters)
    }
}
