//
//  StatisticDayItem.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 24/02/2022.
//

import UIKit

struct StatisticDayItem: Equatable, EmptyDateItem {
    let date: Date
    let exercisingTimeMinutes: String
    let exercisingTimeSeconds: Int
    let progress: StatisticProgress

    init(date: Date, exercisingTimeMinutes: String, exercisingTimeSeconds: Int, progress: StatisticProgress) {
        self.date = date
        self.exercisingTimeMinutes = exercisingTimeMinutes
        self.exercisingTimeSeconds = exercisingTimeSeconds
        self.progress = progress
    }

    static func emptyItem(for date: Date) -> EmptyDateItem {
        StatisticDayItem(date: date, exercisingTimeMinutes: "", exercisingTimeSeconds: 0, progress: .empty)
    }
}
