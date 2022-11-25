//
//  DateRangeTestCase.swift
//  BrainUpTests
//
//  Created by Andrei Trukhan on 25/11/2022.
//

import XCTest
@testable import BrainUp

final class DateRangeTestCase: XCTestCase {
    private let fixedDateInPast = Date(timeIntervalSince1970: 0)
    private let nextDayAfterFixedDateInPast = Date(timeIntervalSince1970: 24 * 60 * 60)
    private let twoDayAfterFixedDateInPast = Date(timeIntervalSince1970: 24 * 60 * 60 * 2)

    func testUpdateWithEarlyStartDate() {
        var oldDateRange = DateRange(startDate: nextDayAfterFixedDateInPast, endDate: twoDayAfterFixedDateInPast)

        XCTAssertEqual(oldDateRange.startDate, nextDayAfterFixedDateInPast)
        XCTAssertEqual(oldDateRange.endDate, twoDayAfterFixedDateInPast)

        let newDateRange = DateRange(startDate: fixedDateInPast, endDate: twoDayAfterFixedDateInPast)

        oldDateRange.update(newDateRange)

        XCTAssertEqual(oldDateRange.startDate, fixedDateInPast)
        XCTAssertEqual(oldDateRange.endDate, twoDayAfterFixedDateInPast)
    }

    func testUpdateWithFutureEndDate() {
        var oldDateRange = DateRange(startDate: fixedDateInPast, endDate: nextDayAfterFixedDateInPast)

        let newDateRange = DateRange(startDate: fixedDateInPast, endDate: twoDayAfterFixedDateInPast)

        oldDateRange.update(newDateRange)

        XCTAssertEqual(oldDateRange.startDate, fixedDateInPast)
        XCTAssertEqual(oldDateRange.endDate, twoDayAfterFixedDateInPast)
    }

    func testUpdateWithStartDateInsideRange() {
        var oldDateRange = DateRange(startDate: fixedDateInPast, endDate: twoDayAfterFixedDateInPast)

        let newDateRange = DateRange(startDate: nextDayAfterFixedDateInPast, endDate: twoDayAfterFixedDateInPast)

        oldDateRange.update(newDateRange)

        XCTAssertEqual(oldDateRange.startDate, fixedDateInPast)
        XCTAssertEqual(oldDateRange.endDate, twoDayAfterFixedDateInPast)
    }

    func testUpdateWithEndDateInsideRange() {
        var oldDateRange = DateRange(startDate: fixedDateInPast, endDate: twoDayAfterFixedDateInPast)

        let newDateRange = DateRange(startDate: fixedDateInPast, endDate: nextDayAfterFixedDateInPast)

        oldDateRange.update(newDateRange)

        XCTAssertEqual(oldDateRange.startDate, fixedDateInPast)
        XCTAssertEqual(oldDateRange.endDate, twoDayAfterFixedDateInPast)
    }
}
