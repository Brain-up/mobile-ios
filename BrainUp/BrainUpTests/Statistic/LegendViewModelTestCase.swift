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
        let days = StatisticDayItemFactory.prepareDates()
        let week = StatisticWeekItem(days: days)

        let viewModel = LegendViewModel(week: week)

        check(dayItem: days[0], legendItem: viewModel.items[0])
        check(dayItem: days[1], legendItem: viewModel.items[1])
        check(dayItem: days[2], legendItem: viewModel.items[2])
    }

    private func check(dayItem: StatisticDayItem, legendItem: LegendItem, file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertEqual(dayItem.date.weekdayLocalizedName(), legendItem.weekday)
        XCTAssertEqual(dayItem.date.dayNumber(), legendItem.date)
        XCTAssertEqual(dayItem.date.isFutureDay(), legendItem.isFutureDay)
        XCTAssertEqual(dayItem.date.isTheCurrentDay(), legendItem.isSelected)
    }
}

class StatisticDayItemFactory {
    static func prepareDates() -> [StatisticDayItem] {
        let pastDayItem = StatisticDayItem(
            date: Date(timeIntervalSince1970: 0),
            exercisingTimeMinutes: "10",
            exercisingTimeSeconds: 600,
            progress: .good)

        let currentDayItem = StatisticDayItem(
            date: Date(),
            exercisingTimeMinutes: "0",
            exercisingTimeSeconds: 0,
            progress: .bad)

        let futureDayItem = StatisticDayItem(
            date: Date().addingTimeInterval(24 * 60 * 60 * 60),
            exercisingTimeMinutes: "100",
            exercisingTimeSeconds: 6000,
            progress: .great)

        return [pastDayItem, currentDayItem, futureDayItem]
    }

    static func createWholeWeek(weekMultipiller: Int = 0) -> [StatisticDayItem] {
        var week = [StatisticDayItem]()
        for index in -1...5 {
            let day = StatisticDayItem(
                date: Date(timeIntervalSince1970: TimeInterval(24 * 60 * 60 * index + weekMultipiller * 24 * 60 * 60)),
                exercisingTimeMinutes: "\(index * 10 * weekMultipiller)",
                exercisingTimeSeconds: 60 * index * 10 * weekMultipiller,
                progress: .good)
            week.append(day)
        }
        return week
    }
}
