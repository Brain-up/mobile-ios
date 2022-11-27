//
//  StatisticDateHelperTestCase.swift
//  BrainUpTests
//
//  Created by Andrei Trukhan on 27/11/2022.
//

import XCTest
@testable import BrainUp

final class StatisticDateHelperTestCase: XCTestCase {
    private let fixedDateInPast = Date(timeIntervalSince1970: 0)
    private let nextDayAfterFixedDateInPast = Date(timeIntervalSince1970: 24 * 60 * 60)
    private let firstDayofWeekInPast = Date(timeIntervalSince1970: 24 * 60 * 60 * 4)
    private let secondDayofWeekInPast = Date(timeIntervalSince1970: 24 * 60 * 60 * 5)
    private let lastDayofWeekInPast = Date(timeIntervalSince1970: 24 * 60 * 60 * 10)

    func testDateDayFormatter() {
        let formatter = StatisticDateHelper.dateDayFormatter
        let dateString = formatter.string(from: fixedDateInPast)
        XCTAssertEqual(dateString, "1970-01-01T00:00:00")
    }

    func testDateMonthFormatter() {
        let formatter = StatisticDateHelper.dateMonthFormatter
        let dateString = formatter.string(from: fixedDateInPast)
        XCTAssertEqual(dateString, "1970-01")
    }

    func testDateRangeString() {
        let dateRange = DateRange(startDate: fixedDateInPast, endDate: nextDayAfterFixedDateInPast)
        let dateRangeString = StatisticDateHelper.dateRangeString(from: dateRange)

        XCTAssertEqual(dateRangeString.startDate, "1970-01-01T00:00:00")
        XCTAssertEqual(dateRangeString.endDate, "1970-01-02T00:00:00")
    }

    func testFirstDayOfWeek() {
        let firstDayOfWeek = StatisticDateHelper.firstDayOfWeek(for: firstDayofWeekInPast)

        XCTAssertEqual(firstDayOfWeek, firstDayofWeekInPast)

        let firstDayOfWeekForSecondDay = StatisticDateHelper.firstDayOfWeek(for: firstDayofWeekInPast)
        XCTAssertEqual(firstDayOfWeekForSecondDay, firstDayofWeekInPast)

        let firstDayOfWeekForLastDay = StatisticDateHelper.firstDayOfWeek(for: lastDayofWeekInPast)
        XCTAssertEqual(firstDayOfWeekForLastDay, firstDayofWeekInPast)
    }

    func testCalculateStartEndDatesDefault() {
        let secondDayOfWeek = Date(timeIntervalSince1970: 24 * 60 * 60 * 19)
        let lastDayOfWeek = Date(timeIntervalSince1970: 24 * 60 * 60 * 24)
        let (dateRangeString, dateRange) = StatisticDateHelper.calculateStartEndDates(for: secondDayOfWeek)
    
        XCTAssertEqual(dateRangeString.startDate, "1970-01-05T00:00:00")
        XCTAssertEqual(dateRangeString.endDate, "1970-01-25T00:00:00")
        XCTAssertEqual(dateRange.startDate, firstDayofWeekInPast)
        XCTAssertEqual(dateRange.endDate, lastDayOfWeek)

        let firstDayOfWeek = Date(timeIntervalSince1970: 24 * 60 * 60 * 18)

        let (dateRangeString1, dateRange1) = StatisticDateHelper.calculateStartEndDates(for: firstDayOfWeek)
    
        XCTAssertEqual(dateRangeString1.startDate, "1970-01-05T00:00:00")
        XCTAssertEqual(dateRangeString1.endDate, "1970-01-25T00:00:00")
        XCTAssertEqual(dateRange1.startDate, firstDayofWeekInPast)
        XCTAssertEqual(dateRange1.endDate, lastDayOfWeek)

        let (dateRangeString2, dateRange2) = StatisticDateHelper.calculateStartEndDates(for: lastDayOfWeek)
    
        XCTAssertEqual(dateRangeString2.startDate, "1970-01-05T00:00:00")
        XCTAssertEqual(dateRangeString2.endDate, "1970-01-25T00:00:00")
        XCTAssertEqual(dateRange2.startDate, firstDayofWeekInPast)
        XCTAssertEqual(dateRange2.endDate, lastDayOfWeek)
    }

    func testCalculateStartEndYearDates() {
        let firstDayOfYear = fixedDateInPast
        let lastDayOfYear = Date(timeIntervalSince1970: 24 * 60 * 60 * 364)
    
        let (dateRangeString, dateRange) = StatisticDateHelper.calculateStartEndYearDates(for: firstDayOfYear)

        XCTAssertEqual(dateRangeString.startDate, "1970-01-01T00:00:00")
        XCTAssertEqual(dateRangeString.endDate, "1970-12-31T00:00:00")
        XCTAssertEqual(dateRange.startDate, firstDayOfYear)
        XCTAssertEqual(dateRange.endDate, lastDayOfYear)

        let (dateRangeString1, dateRange1) = StatisticDateHelper.calculateStartEndYearDates(for: nextDayAfterFixedDateInPast)

        XCTAssertEqual(dateRangeString1.startDate, "1970-01-01T00:00:00")
        XCTAssertEqual(dateRangeString1.endDate, "1970-12-31T00:00:00")
        XCTAssertEqual(dateRange1.startDate, firstDayOfYear)
        XCTAssertEqual(dateRange1.endDate, lastDayOfYear)

        let (dateRangeString2, dateRange2) = StatisticDateHelper.calculateStartEndYearDates(for: lastDayOfYear)

        XCTAssertEqual(dateRangeString2.startDate, "1970-01-01T00:00:00")
        XCTAssertEqual(dateRangeString2.endDate, "1970-12-31T00:00:00")
        XCTAssertEqual(dateRange2.startDate, firstDayOfYear)
        XCTAssertEqual(dateRange2.endDate, lastDayOfYear)
    }

    func testCalculateStartEndYearDatesForFutureItems() {
        let lastDayOfYear = Date(timeIntervalSince1970: 24 * 60 * 60 * 364)

        let firstDayOfNextYear = Date(timeIntervalSince1970: 24 * 60 * 60 * 365)
        let lastDayOfNextYear = Date(timeIntervalSince1970: 24 * 60 * 60 * 364 * 2 + 24 * 60 * 60)

        let (dateRangeString, dateRange) = StatisticDateHelper.calculateStartEndYearDatesForFutureItems(for: lastDayOfYear)

        XCTAssertEqual(dateRangeString.startDate, "1971-01-01T00:00:00")
        XCTAssertEqual(dateRangeString.endDate, "1971-12-31T00:00:00")
        XCTAssertEqual(dateRange.startDate, firstDayOfNextYear)
        XCTAssertEqual(dateRange.endDate, lastDayOfNextYear)
    }

    func testCalculateStartEndDatesForFutureItems() {
        let lastDayOfWeek = Date(timeIntervalSince1970: 24 * 60 * 60 * 17)
        let (dateRangeString, dateRange) = StatisticDateHelper.calculateStartEndDatesForFutureItems(for: firstDayofWeekInPast)
    
        XCTAssertEqual(dateRangeString.startDate, "1970-01-05T00:00:00")
        XCTAssertEqual(dateRangeString.endDate, "1970-01-18T00:00:00")
        XCTAssertEqual(dateRange.startDate, firstDayofWeekInPast)
        XCTAssertEqual(dateRange.endDate, lastDayOfWeek)
    }

}
