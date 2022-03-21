//
//  ChartCellViewModel.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 22/02/2022.
//

import Foundation

protocol ChartCellViewModelProtocol {
    var chartViewModel: GraphicViewModelProtocol { get }
    var legendViewModel: LegendViewModelProtocol { get }
    var monthLabel: String { get }
    var maxTimeValueInSec: Int { get }
    var shouldShowDashedLine: Bool { get }
    var dashedLineBottonContstant: Double { get }
    var firstDayOfWeek: Date { get }
}

struct ChartCellViewModel: ChartCellViewModelProtocol {
    private let minimumGreatTimeThreshold = 20 * 60 // 20 minutes in sec
    private let maxHeightOfBar: Double = 80

    let chartViewModel: GraphicViewModelProtocol
    let legendViewModel: LegendViewModelProtocol
    let monthLabel: String
    let maxTimeValueInSec: Int
    let firstDayOfWeek: Date

    var shouldShowDashedLine: Bool {
        maxTimeValueInSec > minimumGreatTimeThreshold
    }

    var dashedLineBottonContstant: Double {
        maxHeightOfBar * Double(minimumGreatTimeThreshold) / Double(maxTimeValueInSec)
    }

    init(week: StatisticWeekItem, monthLabel: String) {
        self.monthLabel = monthLabel
        self.chartViewModel = GraphicViewModel(week: week, maxHeightOfBar: maxHeightOfBar)
        self.legendViewModel = LegendViewModel(week: week)
        self.maxTimeValueInSec = week.maxTimeValue
        self.firstDayOfWeek = week.firstDayOfWeek
    }
}
