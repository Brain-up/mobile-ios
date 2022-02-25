//
//  StatisticMonthItem.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 24/02/2022.
//

import UIKit

protocol EmptyDateItem {
    var date: Date { get }
    static func emptyItem(for date: Date) -> EmptyDateItem
}

struct StatisticMonthItem: Equatable, EmptyDateItem {
    let date: Date
    let exercisingTimeHours: String
    let exercisingDays: Int
    let progress: StatisticProgress

    init(date: Date, exercisingTimeHours: String, exercisingDays: Int, progress: StatisticProgress) {
        self.date = date
        self.exercisingTimeHours = exercisingTimeHours
        self.exercisingDays = exercisingDays
        self.progress = progress
    }

    static func emptyItem(for date: Date) -> EmptyDateItem {
        StatisticMonthItem(date: date, exercisingTimeHours: "", exercisingDays: 0, progress: .unspecified)
    }
}
