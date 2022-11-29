//
//  ChartCellViewModelTestCase.swift
//  BrainUpTests
//
//  Created by Andrei Trukhan on 29/11/2022.
//

import XCTest
@testable import BrainUp

final class ChartCellViewModelTestCase: XCTestCase {
    func testShouldShowDashedLine() {
        let greatDayItem = StatisticDayItem(
            date: Date().addingTimeInterval(24 * 60 * 60 * 60),
            exercisingTimeMinutes: "100",
            exercisingTimeSeconds: 6000,
            progress: .great)

        let badDayItem = StatisticDayItem(
            date: Date().addingTimeInterval(24 * 60 * 60 * 60),
            exercisingTimeMinutes: "19",
            exercisingTimeSeconds: 19 * 60,
            progress: .great)

        let greatWeek = StatisticWeekItem(days: [greatDayItem])

        let viewModel = ChartCellViewModel(week: greatWeek, monthLabel: "Month")

        XCTAssertTrue(viewModel.shouldShowDashedLine)

        let badWeek = StatisticWeekItem(days: [badDayItem])

        let badViewModel = ChartCellViewModel(week: badWeek, monthLabel: "Month")

        XCTAssertFalse(badViewModel.shouldShowDashedLine)
    }

    func testDashedLineBottonContstant() {
        let maxSec = 4800
        let minimumGreatTimeThreshold = 20 * 60 // 20 minutes in sec
        let greatDayItem = StatisticDayItem(
            date: Date().addingTimeInterval(24 * 60 * 60 * 60),
            exercisingTimeMinutes: "80",
            exercisingTimeSeconds: maxSec,
            progress: .great)

        let goodDayItem = StatisticDayItem(
            date: Date().addingTimeInterval(24 * 60 * 60 * 60),
            exercisingTimeMinutes: "60",
            exercisingTimeSeconds: 3600,
            progress: .good)

        let greatWeek = StatisticWeekItem(days: [greatDayItem, goodDayItem])

        let viewModel = ChartCellViewModel(week: greatWeek, monthLabel: "Month")

        XCTAssertEqual(viewModel.dashedLineBottonContstant, 80 * Double(minimumGreatTimeThreshold) / Double(maxSec))
    }
}
