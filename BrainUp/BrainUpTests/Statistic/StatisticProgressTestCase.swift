//
//  StatisticProgressTestCase.swift
//  BrainUpTests
//
//  Created by Andrei Trukhan on 27/11/2022.
//

import XCTest
@testable import BrainUp

final class StatisticProgressTestCase: XCTestCase {
    func testBarColor() {
        let progress = StatisticProgress.good
        let progressEmpty = StatisticProgress.empty
        let progressFuture = StatisticProgress.future

        XCTAssertEqual(progress.barColor, .yellowWarm)
        XCTAssertEqual(progressEmpty.barColor, .clear)
        XCTAssertEqual(progressFuture.barColor, .clear)
    }

    func testTimeColor() {
        let progress = StatisticProgress.good
        let progressEmpty = StatisticProgress.empty
        let progressFuture = StatisticProgress.future

        XCTAssertEqual(progress.timeColor, .yellowWarmDark)
        XCTAssertEqual(progressEmpty.barColor, .clear)
        XCTAssertEqual(progressFuture.barColor, .clear)
    }

    func testMonthImage() {
        let progress = StatisticProgress.good
        
        StatisticProgress.allCases.forEach {
            XCTAssertNotNil($0.monthImage)
        }
    }

    func testMatchedCase() {
        let great = StatisticProgress.matchedCase(for: "GREAT")
        let good = StatisticProgress.matchedCase(for: "GOOD")
        let bad = StatisticProgress.matchedCase(for: "BAD")
        let empty = StatisticProgress.matchedCase(for: "empty")
        let future = StatisticProgress.matchedCase(for: "future")
        let error = StatisticProgress.matchedCase(for: "great")

        XCTAssertEqual(great, .great)
        XCTAssertEqual(good, .good)
        XCTAssertEqual(bad, .bad)
        XCTAssertEqual(empty, .empty)
        XCTAssertEqual(future, .future)
        XCTAssertEqual(error, .empty)
    }
}
