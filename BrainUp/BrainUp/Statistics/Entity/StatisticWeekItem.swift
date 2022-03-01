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

    init(days: [StatisticDayItem]) {
        self.days = days
        let maxTime = days.sorted { $0.exercisingTimeSeconds > $1.exercisingTimeSeconds }.first?.exercisingTimeSeconds ?? 0
        self.maxTimeValue = maxTime == 0 ? 1 : maxTime
    }

    var monthLabel: String {
        guard let item = days.first(where: { $0.date.dayNumber() == "01" }) else { return "" }
        return item.date.monthLocalizedName().uppercased()
    }
}
