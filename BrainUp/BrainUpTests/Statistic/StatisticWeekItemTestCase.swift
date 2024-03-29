//
//  StatisticWeekItemTestCase.swift
//  BrainUpTests
//
//  Created by Andrei Trukhan on 24/11/2022.
//

import XCTest
@testable import BrainUp

final class StatisticWeekItemTestCase: XCTestCase {
    func testInitCorrectData() {
        let firstDayItem = StatisticDayItem(
            date: Date(timeIntervalSince1970: 0),
            exercisingTimeMinutes: "10",
            exercisingTimeSeconds: 1,
            progress: .good)
        
        let secondDayItem = StatisticDayItem(
            date: Date(timeIntervalSince1970: 24 * 60 * 60),
            exercisingTimeMinutes: "10",
            exercisingTimeSeconds: 1000,
            progress: .good)
        
        let thirdDayItem = StatisticDayItem(
            date: Date(timeIntervalSince1970: 24 * 60 * 60 * 2),
            exercisingTimeMinutes: "1",
            exercisingTimeSeconds: 100,
            progress: .bad)
        
        let days = [firstDayItem, secondDayItem, thirdDayItem]
        
        let week = StatisticWeekItem(days: days)
        
        XCTAssertEqual(week.days.count, days.count)
        XCTAssertEqual(week.maxTimeValue, secondDayItem.exercisingTimeSeconds)
        XCTAssertEqual(week.firstDayOfWeek, firstDayItem.date)
        XCTAssertEqual(week.monthLabel, firstDayItem.date.monthLocalizedName().uppercased())
        
        let daysWithoutFirstDayOfMonth = Array(days.dropFirst())
        let weekFromSecondDay = StatisticWeekItem(days: daysWithoutFirstDayOfMonth)
        XCTAssertEqual(weekFromSecondDay.monthLabel, "")
    }

    func testInitWithEmptyDays() {
        let days: [StatisticDayItem] = []
        
        let week = StatisticWeekItem(days: days)
        
        XCTAssertEqual(week.days.count, days.count)
        XCTAssertEqual(week.maxTimeValue, 1)
        XCTAssertEqual(week.monthLabel, "")
    }
}

final class StatisticDayItemTestCase: XCTestCase {
    private let fixedDateInPast = Date(timeIntervalSince1970: 0)

    func testEmptyItem() {
        let item = StatisticDayItem.emptyItem(for: fixedDateInPast) as? StatisticDayItem

        XCTAssertEqual(item?.date, fixedDateInPast)
        XCTAssertEqual(item?.exercisingTimeMinutes, "")
        XCTAssertEqual(item?.exercisingTimeSeconds, 0)
        XCTAssertEqual(item?.progress, .empty)
    }
}

final class StatisticMonthItemTestCase: XCTestCase {
    private let fixedDateInPast = Date(timeIntervalSince1970: 0)
    private let fixedDateInFuture = Date(timeIntervalSince1970: 365 * 24 * 60 * 60 * 500)

    func testEmptyItem() {
        let item = StatisticMonthItem.emptyItem(for: fixedDateInPast) as? StatisticMonthItem

        XCTAssertEqual(item?.date, fixedDateInPast)
        XCTAssertEqual(item?.exercisingTimeHours, "")
        XCTAssertEqual(item?.exercisingDays, 0)
        XCTAssertEqual(item?.progress, .empty)

        let itemInFuture = StatisticMonthItem.emptyItem(for: fixedDateInFuture) as? StatisticMonthItem

        XCTAssertEqual(itemInFuture?.date, fixedDateInFuture)
        XCTAssertEqual(itemInFuture?.exercisingTimeHours, "")
        XCTAssertEqual(itemInFuture?.exercisingDays, 0)
        XCTAssertEqual(itemInFuture?.progress, .future)
    }
}
