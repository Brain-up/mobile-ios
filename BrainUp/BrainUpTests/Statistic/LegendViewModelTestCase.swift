//
//  LegendViewModelTest.swift
//  BrainUpTests
//
//  Created by Andrei Trukhan on 24/11/2022.
//

import XCTest
@testable import BrainUp

final class LegendViewModelTestCase: XCTestCase {
    func testInit() {
        let pastDayItem = StatisticDayItem(
            date: Date(timeIntervalSince1970: 0),
            exercisingTimeMinutes: "10",
            exercisingTimeSeconds: 100,
            progress: .good)

        let currentDayItem = StatisticDayItem(
            date: Date(),
            exercisingTimeMinutes: "1",
            exercisingTimeSeconds: 1,
            progress: .bad)

        let futureDayItem = StatisticDayItem(
            date: Date().addingTimeInterval(24 * 60 * 60 * 60),
            exercisingTimeMinutes: "10",
            exercisingTimeSeconds: 100,
            progress: .good)

        let week = StatisticWeekItem(days: [pastDayItem, currentDayItem, futureDayItem])

        let viewModel = LegendViewModel(week: week)

        check(dayItem: pastDayItem, legendItem: viewModel.items[0])
        check(dayItem: currentDayItem, legendItem: viewModel.items[1])
        check(dayItem: futureDayItem, legendItem: viewModel.items[2])
    }

    private func check(dayItem: StatisticDayItem, legendItem: LegendItem, file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertEqual(dayItem.date.weekdayLocalizedName(), legendItem.weekday)
        XCTAssertEqual(dayItem.date.dayNumber(), legendItem.date)
        XCTAssertEqual(dayItem.date.isFutureDay(), legendItem.isFutureDay)
        XCTAssertEqual(dayItem.date.isTheCurrentDay(), legendItem.isSelected)
    }
}
