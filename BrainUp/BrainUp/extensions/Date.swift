//
//  Date.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 19/02/2022.
//

import Foundation

extension Date {
    func weekdayLocalizedName() -> String {
        let prefLanguage = Locale.preferredLanguages[0]
        var calendar = Calendar.current
        calendar.locale = NSLocale(localeIdentifier: prefLanguage) as Locale
        let currentWeekday = calendar.dateComponents([.weekday], from: self).weekday ?? 1
        let name = calendar.shortWeekdaySymbols[currentWeekday - 1].uppercased()
        return name
    }

    func monthLocalizedName() -> String {
        let calendar = Calendar.current
        let monthSymbols = LocalizedMonthName.allCases
        let currentMonth = calendar.dateComponents([.month], from: self).month ?? 1
        let name = monthSymbols[currentMonth - 1].rawValue.localized
        return name
    }

    func dayNumber() -> String {
        let dayFormatter = DateFormatter()
        dayFormatter.calendar = Calendar.current
        dayFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dayFormatter.dateFormat = "dd"
        
        return dayFormatter.string(from: self)
    }

    func isFutureDay() -> Bool {
        return self.currentDayWithoutTime() > Date().currentDayWithoutTime()
    }

    func isTheCurrentDay() -> Bool {
        return isTheSameDay(with: Date().currentDayWithoutTime())
    }

    func isTheCurrentMonth() -> Bool {
        return isTheSameMonth(with: Date().currentMonth())
    }

    func isTheSameDay(with anotherDay: Date) -> Bool {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: self, to: anotherDay)
        return components.day == 0
    }

    func isTheSameMonth(with anotherDay: Date) -> Bool {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0) ?? TimeZone.current
        let components = calendar.dateComponents([.month, .year], from: self.currentMonth(), to: anotherDay)
        return components.month == 0 && components.year == 0
    }
    
    /// Adds days to Date.
    /// - Parameter count: The number of days. Pass negative value to get Date before passed Date.
    /// - Returns: Updated Date. If something goes wrong, will return the same Date.
    func addDays(count: Int) -> Date {
        let calendar = Calendar.current
        var dayComponent = DateComponents()
        dayComponent.day = count
        return calendar.date(byAdding: dayComponent, to: self) ?? self
    }
    /// Adds months to Date.
    /// - Parameter count: The number of months. Pass negative value to get Date before passed Date.
    /// - Returns: Updated Date. If something goes wrong, will return the same Date.
    func addMonths(count: Int) -> Date {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0) ?? TimeZone.current
        let currentDay = calendar.dateComponents([.year, .month, .day], from: self).date ?? self
        let nextMonth = calendar.date(byAdding: .month,
                                       value: count,
                                       to: currentDay,
                                       wrappingComponents: false)
        return nextMonth ?? self
    }

    /// Adds years to Date.
    /// - Parameter count: The number of years. Pass negative value to get Date before passed Date.
    /// - Returns: Updated Date. If something goes wrong, will return the same Date.
    func addYears(count: Int) -> Date {
        let calendar = Calendar.current
        
        var yearComponent = DateComponents()
        yearComponent.year = count
        return calendar.date(byAdding: yearComponent, to: self) ?? self
    }
    
    ///  Current day without time
    /// - Returns: Current Date with time 00:00:00 UTC. If something goes wrong, will return the same Date.
    func currentDayWithoutTime() -> Date {
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: self)
        dateComponents.timeZone = TimeZone(secondsFromGMT: 0)
        return calendar.date(from: dateComponents) ?? self
    }

    func currentMonth() -> Date {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0) ?? TimeZone.current
        var dateComponents = calendar.dateComponents([.year, .month], from: self)
        dateComponents.timeZone = TimeZone(secondsFromGMT: 0)
        return calendar.date(from: dateComponents) ?? self
    }

    func europeanWeekDay() -> Int {
        var currentWeekday = Calendar.current.dateComponents([.weekday], from: self).weekday ?? 1
        if currentWeekday == 1 {
            currentWeekday = 7
        } else {
            currentWeekday -= 1
        }
        return currentWeekday
    }

    func year() -> String {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: self)
        return "\(year)"
    }

    func lastDayOfCurrentYear() -> Date {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: self)
        let endOfYear = Calendar.current.date(from: DateComponents(year: year, month: 12, day: 31)) ?? self
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: endOfYear)
        dateComponents.timeZone = TimeZone(secondsFromGMT: 0)
        return calendar.date(from: dateComponents) ?? self
    }

    func firstDayOfCurrentYear() -> Date {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: self)
        let endOfYear = calendar.date(from: DateComponents(year: year, month: 1, day: 1)) ?? self
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: endOfYear)
        dateComponents.timeZone = TimeZone(secondsFromGMT: 0)
        return calendar.date(from: dateComponents) ?? self
    }
}

enum LocalizedMonthName: String, CaseIterable {
    case january = "monthName.january"
    case february = "monthName.february"
    case march = "monthName.march"
    case april = "monthName.april"
    case may = "monthName.may"
    case june = "monthName.june"
    case july = "monthName.july"
    case august = "monthName.august"
    case september = "monthName.september"
    case october = "monthName.october"
    case november = "monthName.november"
    case december = "monthName.december"
}
