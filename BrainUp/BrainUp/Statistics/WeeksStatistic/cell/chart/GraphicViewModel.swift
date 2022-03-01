//
//  GraphicViewModel.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 26/02/2022.
//

import Foundation

protocol GraphicViewModelProtocol {
    var items: [ColumnViewModelProtocol] { get }
}

struct GraphicViewModel: GraphicViewModelProtocol {

    private(set) var items: [ColumnViewModelProtocol] = []

    init(week: StatisticWeekItem, maxHeightOfBar: Double) {
        items = week.days.map { day in
            let multiplier = Double(day.exercisingTimeSeconds) / Double(week.maxTimeValue)
            let correctedMultiplier = multiplier == 0 ? 1 : multiplier
            let height = maxHeightOfBar * correctedMultiplier
            return ColumnViewModel(columnHeight: Double(height),
                                            columnColor: day.progress.barColor,
                                            timeColor: day.progress.timeColor,
                                            time: day.exercisingTimeMinutes)
        }
    }
}
