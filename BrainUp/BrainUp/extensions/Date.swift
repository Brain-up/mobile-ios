//
//  Date.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 19/02/2022.
//

import Foundation
extension Date {
    func isTheCurrentDay() -> Bool {
        return isTheSameDay(with: Date())
    }

    func isTheSameDay(with anotherDay: Date) -> Bool {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: self, to: anotherDay)
        return components.day == 0
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
    
    ///  Current day without time
    /// - Returns: Current Date with time 00:00:00 UTC. If something goes wrong, will return the same Date.
    func currentDayWithoutTime() -> Date {
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: self)
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
}
