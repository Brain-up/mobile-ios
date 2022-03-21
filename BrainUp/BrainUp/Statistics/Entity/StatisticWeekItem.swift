//
//  StatisticWeekItem.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 25/02/2022.
//

import Foundation

struct StatisticWeekItem: Equatable {
    let days: [StatisticDayItem]
    let maxTimeValue: Int
    let firstDayOfWeek: Date

    init(days: [StatisticDayItem], dateDayFormatter: DateFormatter) {
        self.days = days
        let maxTime = days.sorted { $0.exercisingTimeSeconds > $1.exercisingTimeSeconds }.first?.exercisingTimeSeconds ?? 0
        self.maxTimeValue = maxTime == 0 ? 1 : maxTime

        self.firstDayOfWeek = days.first?.date ?? Date()
    }

    var monthLabel: String {
        guard let item = days.first(where: { $0.date.dayNumber() == "01" }) else { return "" }
        return item.date.monthLocalizedName().uppercased()
    }
}
