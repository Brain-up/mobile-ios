//
//  StatisticDateHelper.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 24/02/2022.
//

import Foundation

protocol StatisticDateHelperProtocol {
    static var dateDayFormatter: DateFormatter { get }
    static var dateMonthFormatter: DateFormatter { get }
    static func calculateStartEndDates(for date: Date) -> (DateRange)
}

class StatisticDateHelper: StatisticDateHelperProtocol {
    static var dateDayFormatter: DateFormatter {
        let dayFormatter = DateFormatter()
        dayFormatter.calendar = Calendar(identifier: .iso8601)
        dayFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dayFormatter.dateFormat = "yyyy-MM-dd"
        return dayFormatter
    }

    static var dateMonthFormatter: DateFormatter {
        let dayFormatter = DateFormatter()
        dayFormatter.calendar = Calendar(identifier: .iso8601)
        dayFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dayFormatter.dateFormat = "yyyy-MM"
        return dayFormatter
    }

    static func calculateStartEndDates(for date: Date) -> (DateRange) {
        let currentDate = date.currentDayWithoutTime()
        let currentWeekday = currentDate.europeanWeekDay()
        let endDate = currentDate.addDays(count: 7 - currentWeekday)
        let startDayOfWeek = currentDate.addDays(count: -(currentWeekday - 1))
        let startDate = startDayOfWeek.addDays(count: -2 * 7) // 7 - length of week
        
        let startDateString = dateDayFormatter.string(from: startDate)
        let endDateString = dateDayFormatter.string(from: endDate)

        return (startDateString, endDateString)
    }
}
