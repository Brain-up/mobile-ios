//
//  WeekStatisticViewModelTestCase.swift
//  BrainUpTests
//
//  Created by Andrei Trukhan on 29/11/2022.
//

import XCTest
@testable import BrainUp

final class WeekStatisticViewModelTestCase: XCTestCase {
    private var firstDays = StatisticDayItemFactory.createWholeWeek(weekMultipiller: 0)
    private var secondDays = StatisticDayItemFactory.createWholeWeek(weekMultipiller: 1)

    private var firstWeek = StatisticWeekItem(days: [])
    private var secondWeek = StatisticWeekItem(days: [])

    private var mondayFirstWeek = Date()
    private var sundayFirstWeek = Date()
    private var mondaySecondWeek = Date()
    private var sundaySecondWeek = Date()

    private var dateRange = DateRange(startDate: Date(), endDate: Date())

    override func setUp() {
        firstWeek = StatisticWeekItem(days: firstDays)
        secondWeek = StatisticWeekItem(days: secondDays)

        mondayFirstWeek = firstDays.first?.date ?? Date()
        sundayFirstWeek = firstDays.last?.date ?? Date()
        mondaySecondWeek = secondDays.first?.date ?? Date()
        sundaySecondWeek = secondDays.last?.date ?? Date()
        dateRange = DateRange(startDate: mondayFirstWeek, endDate: sundaySecondWeek)
    }

    func testNumberOfRows() {
        let viewModel = WeeksStatisticViewModel()
        XCTAssertEqual(viewModel.numberOfRows, 0)

        viewModel.insertItems(with: [firstWeek, secondWeek], dateRangeOfLoadedData: dateRange, showCellWith: mondayFirstWeek)
        XCTAssertEqual(viewModel.numberOfRows, 2)
    }

    func testItemsDirection() {
        let viewModel = WeeksStatisticViewModel()

        viewModel.insertItems(with: [firstWeek, secondWeek], dateRangeOfLoadedData: dateRange, showCellWith: mondayFirstWeek)
        XCTAssertEqual(viewModel.item(for: IndexPath(row: 0, section: 0)).firstDayOfWeek, firstWeek.firstDayOfWeek)
    }

    func testDateRangeOfLoadedData() {
        let viewModel = WeeksStatisticViewModel()
        let currentEndDate = viewModel.dateRangeOfLoadedData.endDate

        let secondWeekDateRange = DateRange(startDate: mondaySecondWeek, endDate: sundaySecondWeek)
        viewModel.insertItems(with: [secondWeek], dateRangeOfLoadedData: secondWeekDateRange, showCellWith: nil)
        XCTAssertEqual(viewModel.dateRangeOfLoadedData.startDate, secondWeekDateRange.startDate)
        XCTAssertEqual(viewModel.dateRangeOfLoadedData.endDate, currentEndDate)

        let firstWeekDateRange = DateRange(startDate: mondayFirstWeek, endDate: sundayFirstWeek)
        viewModel.insertItems(with: [firstWeek], dateRangeOfLoadedData: firstWeekDateRange, showCellWith: mondayFirstWeek)
        XCTAssertEqual(viewModel.dateRangeOfLoadedData.startDate, firstWeekDateRange.startDate)
        XCTAssertEqual(viewModel.dateRangeOfLoadedData.endDate, currentEndDate)
    }

    func testInsertItems() {
        let viewModel = WeeksStatisticViewModel()
        
        var datesInserted = false
        viewModel.insertData = {
            datesInserted = true
        }

        var lastIndexPath = IndexPath(row: -100, section: -100)
        viewModel.updateAndShowCell = { lastCellPath in
            lastIndexPath = lastCellPath
        }
        XCTAssertEqual(viewModel.lastActiveCell, IndexPath(row: 0, section: 0))

        viewModel.insertItems(with: [firstWeek], dateRangeOfLoadedData: dateRange, showCellWith: nil)
        XCTAssertTrue(datesInserted)
        XCTAssertEqual(lastIndexPath, IndexPath(row: -100, section: -100))
        datesInserted = false

        viewModel.insertItems(with: [secondWeek], dateRangeOfLoadedData: dateRange, showCellWith: mondayFirstWeek)
        XCTAssertFalse(datesInserted)
        XCTAssertEqual(lastIndexPath, IndexPath(row: 1, section: 0))
    }

    func testSaveState() {
        let viewModel = WeeksStatisticViewModel()
        let newIndexPath = IndexPath(row: -100, section: -100)

        XCTAssertEqual(viewModel.lastActiveCell, IndexPath(row: 0, section: 0))

        viewModel.saveState(for: newIndexPath)
        XCTAssertEqual(viewModel.lastActiveCell, newIndexPath)
    }

    func testLoadPastStatistic() {
        let viewModel = WeeksStatisticViewModel()
        var count = 0

        viewModel.loadPastData = { date in
            XCTAssertEqual(date, self.mondayFirstWeek)
            count += 1
        }

        viewModel.insertItems(with: [firstWeek], dateRangeOfLoadedData: dateRange, showCellWith: nil)
        viewModel.loadPastStatistic()

        XCTAssertEqual(count, 1)
    }

    func testLoadFeatureStatistic() {
        let viewModel = WeeksStatisticViewModel()
        let endDate = viewModel.dateRangeOfLoadedData.endDate
        var count = 0

        viewModel.loadFutureData = { date in
            XCTAssertEqual(date, endDate)
            count += 1
        }

        viewModel.insertItems(with: [firstWeek], dateRangeOfLoadedData: dateRange, showCellWith: nil)

        viewModel.loadFutureStatistic()
        XCTAssertEqual(count, 1)
    }
}
