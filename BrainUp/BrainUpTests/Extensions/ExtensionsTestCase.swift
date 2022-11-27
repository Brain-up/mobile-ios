//
//  ExtensionsTestCase.swift
//  BrainUpTests
//
//  Created by Andrei Trukhan on 24/11/2022.
//

import XCTest
@testable import BrainUp

final class ExtensionsTestCase: XCTestCase {
    private let array = [1, 2, 3, 4, 5, 6]

    func testArrayChunked() {
        let sixChunksArray = array.chunked(into: 6)
        XCTAssertEqual(sixChunksArray, [array])

        let fiveChunksArray = array.chunked(into: 5)
        XCTAssertEqual(fiveChunksArray, [[1, 2, 3, 4, 5], [6]])

        let oneChunksArray = array.chunked(into: 1)
        XCTAssertEqual(oneChunksArray, [[1], [2], [3], [4], [5], [6]])

        let minusOneChunksArray = array.chunked(into: -1)
        XCTAssertEqual(minusOneChunksArray, [])

        let tenChunksArray = array.chunked(into: 10)
        XCTAssertEqual(tenChunksArray, [array])
    }

    func testIdentifierView() {
        XCTAssertEqual(UIView.identifier, "UIView")
    }
}

final class DateExtensionTestCase: XCTestCase {
    private let fixedDateInPast = Date(timeIntervalSince1970: 0)
    private let futureDate = Date(timeInterval: 24 * 60 * 60, since: Date())

    override func setUp() async throws {
        let language = Locale.preferredLanguages[0]
        XCTAssertEqual(language, "en-US", "Please, set the device language to en-US")
    }

    func testWeekdayLocalizedName() {
        XCTAssertEqual(fixedDateInPast.weekdayLocalizedName(), "THU")
    }

    func testMonthLocalizedName() {
        XCTAssertEqual(fixedDateInPast.monthLocalizedName(), "January")
    }

    func testDayNumber() {
        XCTAssertEqual(fixedDateInPast.dayNumber(), "01")
    }

    func testIsFutureDay() {
        XCTAssertEqual(fixedDateInPast.isFutureDay(), false)
        XCTAssertEqual(futureDate.isFutureDay(), true)
        XCTAssertEqual(Date().isFutureDay(), false)
    }

    func testIsCurrentDay() {
        XCTAssertEqual(Date().isTheCurrentDay(), true)
        XCTAssertEqual(futureDate.isTheCurrentDay(), false)
        XCTAssertEqual(fixedDateInPast.isTheCurrentDay(), false)
    }

    func testIsCurrentMonth() {
        XCTAssertEqual(Date().isTheCurrentMonth(), true)
        XCTAssertEqual(fixedDateInPast.isTheCurrentMonth(), false)
        XCTAssertEqual(fixedDateInPast.isTheCurrentMonth(), false)
    }

    func testIsSameDay() {
        XCTAssertEqual(fixedDateInPast.isTheSameDay(with: nil), false)
        XCTAssertEqual(fixedDateInPast.isTheSameDay(with: fixedDateInPast), true)
    }

    func testIsTheSameMonth() {
        XCTAssertEqual(fixedDateInPast.isTheSameMonth(with: fixedDateInPast), true)
    }

    func testAddDays() {
        let nextDayAfterFixedDateInPast = Date(timeInterval: 24 * 60 * 60, since: fixedDateInPast)

        XCTAssertEqual(fixedDateInPast.addDays(count: 1), nextDayAfterFixedDateInPast)
        XCTAssertEqual(nextDayAfterFixedDateInPast.addDays(count: -1), fixedDateInPast)
    }

    func testAddMonths() {
        let nextMonthAfterFixedDateInPast = Date(timeInterval: 24 * 60 * 60 * 31, since: fixedDateInPast)

        XCTAssertEqual(fixedDateInPast.addMonths(count: 1), nextMonthAfterFixedDateInPast)
        XCTAssertEqual(nextMonthAfterFixedDateInPast.addMonths(count: -1), fixedDateInPast)

        let sameMonthWithFixedDateInPast = Date(timeInterval: 24 * 60 * 60 * 28, since: fixedDateInPast)

        XCTAssertNotEqual(fixedDateInPast.addMonths(count: 1), sameMonthWithFixedDateInPast)
        XCTAssertNotEqual(sameMonthWithFixedDateInPast.addMonths(count: -1), fixedDateInPast)
    }

    func testAddYears() {
        let nextYearAfterFixedDateInPast = Date(timeInterval: 24 * 60 * 60 * 365, since: fixedDateInPast)

        XCTAssertEqual(fixedDateInPast.addYears(count: 1), nextYearAfterFixedDateInPast)
        XCTAssertEqual(nextYearAfterFixedDateInPast.addYears(count: -1), fixedDateInPast)

        let sameYearWithFixedDateInPast = Date(timeInterval: 24 * 60 * 60 * 364, since: fixedDateInPast)

        XCTAssertNotEqual(fixedDateInPast.addYears(count: 1), sameYearWithFixedDateInPast)
        XCTAssertNotEqual(sameYearWithFixedDateInPast.addYears(count: -1), fixedDateInPast)
    }

    func testCurrentDayWithoutTime() {
        let fixedDateInPastWithSeconds = Date(timeInterval: 24 * 60 + 60, since: fixedDateInPast)

        XCTAssertEqual(fixedDateInPastWithSeconds.currentDayWithoutTime(), fixedDateInPast)
    }

    func testEuropeanWeekDay() {
        XCTAssertEqual(fixedDateInPast.europeanWeekDay(), 4)
    }

    func testYear() {
        XCTAssertEqual(fixedDateInPast.year(), "1970")
    }

    func testLastDayOfCurrentYear() {
        let lastYearDayFixedDateInPast = Date(timeInterval: 24 * 60 * 60 * 364, since: fixedDateInPast)

        XCTAssertEqual(lastYearDayFixedDateInPast, fixedDateInPast.lastDayOfCurrentYear())
    }

    func testFirstDayOfCurrentYear() {
        let lastYearDayFixedDateInPast = Date(timeInterval: 24 * 60 * 60 * 364, since: fixedDateInPast)

        XCTAssertEqual(fixedDateInPast, fixedDateInPast.firstDayOfCurrentYear())
        XCTAssertEqual(fixedDateInPast, lastYearDayFixedDateInPast.firstDayOfCurrentYear())
    }
}
