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
    static func calculateStartEndDates(for date: Date) -> (DateRangeString, DateRange)
    static func calculateStartEndYearDates(for date: Date) -> (DateRangeString, DateRange)
    static func calculateStartEndDatesForFutureItems(for date: Date) -> (DateRangeString, DateRange)
    static func calculateStartEndYearDatesForFutureItems(for date: Date) -> (DateRangeString, DateRange)
}

class StatisticDateHelper: StatisticDateHelperProtocol {
    private static let weekLength = 7
    private static let numberOfWeeksToAdd = 2
    
    static var dateDayFormatter: DateFormatter {
        let dayFormatter = DateFormatter()
        dayFormatter.calendar = Calendar.current
        dayFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dayFormatter.dateFormat = "yyyy-MM-dd"
        return dayFormatter
    }

    static var dateMonthFormatter: DateFormatter {
        let dayFormatter = DateFormatter()
        dayFormatter.calendar = Calendar.current
        dayFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dayFormatter.dateFormat = "yyyy-MM"
        return dayFormatter
    }

    static func calculateStartEndDates(for date: Date) -> (DateRangeString, DateRange) {
        let currentDate = date.currentDayWithoutTime()
        let currentWeekday = currentDate.europeanWeekDay()
        let endDate = currentDate.addDays(count: weekLength - currentWeekday)

        let startDayOfWeek = currentDate.addDays(count: -(currentWeekday - 1))
        let startDate = startDayOfWeek.addDays(count: -numberOfWeeksToAdd * weekLength)
        
        let startDateString = dateDayFormatter.string(from: startDate)
        let endDateString = dateDayFormatter.string(from: endDate)

        return ((startDateString, endDateString), (startDate, endDate))
    }

    static func calculateStartEndYearDates(for date: Date) -> (DateRangeString, DateRange) {
        let currentDate = date.currentDayWithoutTime()
        let endDate = currentDate.lastDayOfCurrentYear()
        let startDate = currentDate.firstDayOfCurrentYear()
        
        let startDateString = dateDayFormatter.string(from: startDate)
        let endDateString = dateDayFormatter.string(from: endDate)

        return ((startDateString, endDateString), (startDate, endDate))
    }

    static func calculateStartEndYearDatesForFutureItems(for date: Date) -> (DateRangeString, DateRange) {
        // we expct here to get last day og the year
        let currentDate = date.currentDayWithoutTime().addDays(count: 1)
        let endDate = currentDate.lastDayOfCurrentYear()
        let startDate = currentDate.firstDayOfCurrentYear()
        
        let startDateString = dateDayFormatter.string(from: startDate)
        let endDateString = dateDayFormatter.string(from: endDate)

        return ((startDateString, endDateString), (startDate, endDate))
    }

    static func calculateStartEndDatesForFutureItems(for date: Date) -> (DateRangeString, DateRange) {
        let startDate = date.currentDayWithoutTime()
        let endDate = startDate.addDays(count: numberOfWeeksToAdd * weekLength - 1)
        
        let startDateString = dateDayFormatter.string(from: startDate)
        let endDateString = dateDayFormatter.string(from: endDate)

        return ((startDateString, endDateString), (startDate, endDate))
    }
}
