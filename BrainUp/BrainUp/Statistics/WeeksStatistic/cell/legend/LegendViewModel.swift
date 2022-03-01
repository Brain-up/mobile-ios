//
//  LegendViewModel.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 26/02/2022.
//

import Foundation

protocol LegendViewModelProtocol {
    var items: [LegendItem] { get }
}

struct LegendViewModel: LegendViewModelProtocol {
    private(set) var items: [LegendItem] = []

    init(week: StatisticWeekItem) {
        items = week.days.map { day in
            let isSelected = day.date.isTheCurrentDay()
            let isFutureDay = day.date.isFutureDay()
            return LegendItem(weekday: day.date.weekdayLocalizedName(), date: day.date.dayNumber(), isSelected: isSelected, isFutureDay: isFutureDay)
        }
    }
}

struct LegendItem {
    let weekday: String
    let date: String
    let isSelected: Bool
    let isFutureDay: Bool
}
