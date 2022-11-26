//
//  StatisticRequestTestCase.swift
//  BrainUpTests
//
//  Created by Andrei Trukhan on 25/11/2022.
//

import XCTest
@testable import BrainUp

final class StatisticRequestTestCase: XCTestCase {
    private var weekDateRange = ("2022-11-21T00:00:00", "2022-11-26T00:00:00")
    private var yearDateRange = ("2022-01-01T00:00:00", "2022-12-31T00:00:00")

    func testWeekRequest() {
        let statisticRequest = StatisticRequest.week(weekDateRange)

        XCTAssertEqual(statisticRequest.path, "/v2/statistics/study/week?from=\(weekDateRange.0)&to=\(weekDateRange.1)")
        XCTAssertEqual(statisticRequest.method, .get)
        XCTAssertEqual(statisticRequest.encoding, .JSONEncoding)
        XCTAssertNil(statisticRequest.queryItems)
    }

    func testYearRequest() {
        let statisticRequest = StatisticRequest.year(yearDateRange)

        XCTAssertEqual(statisticRequest.path, "/v2/statistics/study/year?from=\(yearDateRange.0)&to=\(yearDateRange.1)")
        XCTAssertEqual(statisticRequest.method, .get)
        XCTAssertEqual(statisticRequest.encoding, .JSONEncoding)
        XCTAssertNil(statisticRequest.queryItems)
    }

    func testBaseStuff() {
        let statisticRequest = StatisticRequest.year(yearDateRange)
        XCTAssertEqual(statisticRequest.baseURL, "https://brainup.site/api")

        XCTAssertEqual(statisticRequest.headers, [:])
        XCTAssertNil(statisticRequest.parameters)
    }
}
