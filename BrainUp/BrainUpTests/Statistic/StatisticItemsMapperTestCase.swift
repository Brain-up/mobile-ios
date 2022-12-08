//
//  StatisticItemsMapperTestCase.swift
//  BrainUpTests
//
//  Created by Andrei Trukhan on 27/11/2022.
//

import XCTest
@testable import BrainUp

final class StatisticItemsMapperTestCase: XCTestCase {
    struct EmptyDateItemMock: EmptyDateItem {
        var date: Date
        
        static func emptyItem(for date: Date) -> BrainUp.EmptyDateItem {
            EmptyDateItemMock(date: date)
        }
    }

    private let fixedDateInPast = Date(timeIntervalSince1970: 0)
    private let futureDayAfterFixedDateInPast = Date(timeIntervalSince1970: 24 * 60 * 60 * 3)

    func testStatisticItemsWithEmptyValuesForMissedItemsCorrect() {
        let firstDate = EmptyDateItemMock(date: fixedDateInPast)
        let thirdDate = EmptyDateItemMock(date: futureDayAfterFixedDateInPast)
        let dateArray = [firstDate, thirdDate]

        let expectedArrayOfDates = [
            Date(timeIntervalSince1970: 24 * 60 * 60 * 0),
            Date(timeIntervalSince1970: 24 * 60 * 60 * 1),
            Date(timeIntervalSince1970: 24 * 60 * 60 * 2),
            Date(timeIntervalSince1970: 24 * 60 * 60 * 3),
            Date(timeIntervalSince1970: 24 * 60 * 60 * 4),
            Date(timeIntervalSince1970: 24 * 60 * 60 * 5),
            Date(timeIntervalSince1970: 24 * 60 * 60 * 6)
        ]

        let dateRangeString = ("1970-01-01T00:00:00", "1970-01-07T00:00:00")
        let mapper = StatisticItemsMapper()

        let updatedArray = mapper.statisticItemsWithEmptyValuesForMissedItems(inside: dateRangeString, for: dateArray) { date in
            date.addingTimeInterval(24 * 60 * 60)
        }
        
        expectedArrayOfDates.enumerated().forEach { index, expectedDate in
            XCTAssertEqual(updatedArray[index].date, expectedDate)
        }
    }

    func testStatisticItemsWithEmptyValuesForMissedItemsIncorrect() {
        let firstDate = EmptyDateItemMock(date: fixedDateInPast)
        let dateArray = [firstDate]

        let expectedArrayOfDates = [
            Date(timeIntervalSince1970: 24 * 60 * 60 * 0)
        ]

        let dateRangeString = ("1970-01-07T00:00:00", "1970-01-01T00:00:00")
        let mapper = StatisticItemsMapper()

        let updatedArray = mapper.statisticItemsWithEmptyValuesForMissedItems(inside: dateRangeString, for: dateArray) { date in
            date.addingTimeInterval(24 * 60 * 60)
        }
        
        expectedArrayOfDates.enumerated().forEach { index, expectedDate in
            XCTAssertEqual(updatedArray[index].date, expectedDate)
        }
    }
}
