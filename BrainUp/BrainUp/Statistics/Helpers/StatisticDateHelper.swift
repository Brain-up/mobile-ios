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
    static func calculateStartEndDates(for date: Date, numberOfWeeksToAdd: Int) -> (DateRangeString, DateRange)
    static func calculateStartEndYearDates(for date: Date) -> (DateRangeString, DateRange)
    static func calculateStartEndDatesForFutureItems(for date: Date) -> (DateRangeString, DateRange)
    static func calculateStartEndYearDatesForFutureItems(for date: Date) -> (DateRangeString, DateRange)
    static func dateRangeString(from dateRange: DateRange) -> DateRangeString
    static func firstDayOfWeek(for date: Date) -> Date 
}

class StatisticDateHelper: StatisticDateHelperProtocol {
    private static let weekLength = 7
    private static let numberOfWeeksToAdd = 2
    
    static var dateDayFormatter: DateFormatter {
        let dayFormatter = DateFormatter()
        dayFormatter.calendar = Calendar.current
        dayFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dayFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dayFormatter
    }

    static var dateMonthFormatter: DateFormatter {
        let dayFormatter = DateFormatter()
        dayFormatter.calendar = Calendar.current
        dayFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dayFormatter.dateFormat = "yyyy-MM"
        return dayFormatter
    }

    static func dateRangeString(from dateRange: DateRange) -> DateRangeString {
        let startDateString = dateDayFormatter.string(from: dateRange.startDate)
        let endDateString = dateDayFormatter.string(from: dateRange.endDate)
        return (startDateString, endDateString)
    }

    static func firstDayOfWeek(for date: Date) -> Date {
        let currentDate = date.currentDayWithoutTime()
        let currentWeekday = currentDate.europeanWeekDay()
        let startDayOfWeek = currentDate.addDays(count: -(currentWeekday - 1))
        return startDayOfWeek
    }

    static func calculateStartEndDates(for date: Date, numberOfWeeksToAdd: Int = 2) -> (DateRangeString, DateRange) {
        let currentDate = date.currentDayWithoutTime()
        let currentWeekday = currentDate.europeanWeekDay()
        let endDate = currentDate.addDays(count: weekLength - currentWeekday)

        let startDayOfWeek = firstDayOfWeek(for: currentDate)
        let startDate = startDayOfWeek.addDays(count: -numberOfWeeksToAdd * weekLength)

        let dateRange = DateRange(startDate: startDate, endDate: endDate)
        let dateRangeString = dateRangeString(from: dateRange)

        return (dateRangeString, dateRange)
    }

    static func calculateStartEndYearDates(for date: Date) -> (DateRangeString, DateRange) {
        let currentDate = date.currentDayWithoutTime()
        let endDate = currentDate.lastDayOfCurrentYear()
        let startDate = currentDate.firstDayOfCurrentYear()

        let dateRange = DateRange(startDate: startDate, endDate: endDate)
        let dateRangeString = dateRangeString(from: dateRange)

        return (dateRangeString, dateRange)
    }
    /// expect to get the last day of the year
    static func calculateStartEndYearDatesForFutureItems(for date: Date) -> (DateRangeString, DateRange) {
        assert(date.lastDayOfCurrentYear() == date, "Date should be last date of the year")

        let nextYearFirstDate = date.currentDayWithoutTime().addDays(count: 1)
        let endDate = nextYearFirstDate.lastDayOfCurrentYear()
        let startDate = nextYearFirstDate.firstDayOfCurrentYear()

        let dateRange = DateRange(startDate: startDate, endDate: endDate)
        let dateRangeString = dateRangeString(from: dateRange)

        return (dateRangeString, dateRange)
    }

    /// expect to get the first day of the week
    static func calculateStartEndDatesForFutureItems(for date: Date) -> (DateRangeString, DateRange) {
        let startDate = date.currentDayWithoutTime()
        let endDate = startDate.addDays(count: numberOfWeeksToAdd * weekLength - 1)

        let dateRange = DateRange(startDate: startDate, endDate: endDate)
        let dateRangeString = dateRangeString(from: dateRange)

        return (dateRangeString, dateRange)
    }
}
