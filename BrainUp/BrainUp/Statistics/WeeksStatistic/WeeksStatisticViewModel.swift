//
//  WeeksStatisticViewModel.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 22/02/2022.
//

import Foundation

protocol WeeksStatisticViewModelProtocol {
    var numberOfRows: Int { get }
    var reloadData: (() -> Void)? { get set }

    func item(for indexPath: IndexPath) -> ChartCellViewModelProtocol
    func loadPastStatistic()
    func loadFeatureStatistic()
}

class WeeksStatisticViewModel: WeeksStatisticViewModelProtocol {
    private(set) var dataRangeOfLoadedData: DateRange = (Date(), Date())
    private var items: [ChartCellViewModelProtocol] = []
    var reloadData: (() -> Void)?
    var loadPastData: ((Date) -> Void)?
    var loadFeatureData: ((Date) -> Void)?

    func updateItems(with weekItems: [StatisticWeekItem], dataRangeOfLoadedData: DateRange) {
        update(dataRangeOfLoadedData)
        // there we should replace data
        weekItems.reversed().forEach { item in
            items.insert(ChartCellViewModel(week: item, monthLabel: item.monthLabel), at: 0)
        }
        reloadData?()
    }

    func addFutureItems(with weekItems: [StatisticWeekItem], dataRangeOfLoadedData: DateRange) {
        update(dataRangeOfLoadedData)
        weekItems.forEach { item in
            items.append(ChartCellViewModel(week: item, monthLabel: item.monthLabel))
        }
        reloadData?()
    }

    var numberOfRows: Int {
        items.count
    }

    func loadPastStatistic() {
        loadPastData?(dataRangeOfLoadedData.startDate)
    }

    func loadFeatureStatistic() {
        loadFeatureData?(dataRangeOfLoadedData.endDate)
    }

    func item(for indexPath: IndexPath) -> ChartCellViewModelProtocol {
        guard indexPath.row < items.count else {
            return items[0] // empty data
        }
        if indexPath.row == items.count - 1 {
            loadFeatureStatistic()
        }
        return items[indexPath.row]
    }

    private func update(_ dataRangeOfLoadedData: DateRange) {
        if dataRangeOfLoadedData.startDate < self.dataRangeOfLoadedData.startDate {
            self.dataRangeOfLoadedData.startDate = dataRangeOfLoadedData.startDate
            return
        }
        if dataRangeOfLoadedData.endDate > self.dataRangeOfLoadedData.endDate {
            self.dataRangeOfLoadedData.endDate = dataRangeOfLoadedData.endDate
            return
        }
    }
}
