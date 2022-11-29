//
//  ChartViewModelTestCase.swift
//  BrainUpTests
//
//  Created by Andrei Trukhan on 28/11/2022.
//

import XCTest
@testable import BrainUp

final class ChartViewModelTestCase: XCTestCase {

    func testInit() {
        let days = StatisticDayItemFactory.prepareDates()
        let week = StatisticWeekItem(days: days)
        let height: Double = 20

        let viewModel = ChartViewModel(week: week, maxHeightOfBar: height)

        let heights = days.map { item in
            let multiplier = Double(item.exercisingTimeSeconds) / Double(week.maxTimeValue)
            let adjustedMultipiller = multiplier == 0 ? 1 : multiplier
            return height * adjustedMultipiller
        }

        viewModel.items.enumerated().forEach { index, item in
            XCTAssertEqual(item.columnHeight, heights[index])
        }
    }
}
