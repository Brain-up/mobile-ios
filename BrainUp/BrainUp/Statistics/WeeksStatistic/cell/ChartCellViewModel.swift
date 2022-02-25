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
}

struct ChartCellViewModel: ChartCellViewModelProtocol {
    let chartViewModel: GraphicViewModelProtocol = GraphicViewModel()
    let legendViewModel: LegendViewModelProtocol = LegendViewModel()
    let monthLabel: String = "Месяц"
}
