//
//  WeeksStatisticViewModel.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 22/02/2022.
//

import Foundation

protocol WeeksStatisticViewModelProtocol {
    var numberOfRows: Int { get }
    var lastActiveCell: IndexPath { get }
    var reloadData: (() -> Void)? { get set }
    var insertData: (() -> Void)? { get set }
    var updateAndShowCell: ((IndexPath) -> Void)? { get set }

    func item(for indexPath: IndexPath) -> ChartCellViewModelProtocol
    func loadPastStatistic()
    func loadFeatureStatistic()
    func saveState(for indexPath: IndexPath)
}

class WeeksStatisticViewModel: WeeksStatisticViewModelProtocol {
    private var items: [ChartCellViewModelProtocol] = []
    private let lastShowedYear = 2018
    private(set) var dateRangeOfLoadedData = DateRange(startDate: Date(), endDate: Date())

    // MARK: - Coordinator bindings
    var loadPastData: ((Date) -> Void)?
    var loadFeatureData: ((Date) -> Void)?

    // MARK: - WeeksStatisticViewModelProtocol
    var reloadData: (() -> Void)?
    var insertData: (() -> Void)?
    var updateAndShowCell: ((IndexPath) -> Void)?

    var numberOfRows: Int {
        items.count
    }

    private(set) var lastActiveCell = IndexPath(row: 0, section: 0)

    func item(for indexPath: IndexPath) -> ChartCellViewModelProtocol {
        guard indexPath.row < items.count else {
            let week = StatisticWeekItem(days: [])
            return ChartCellViewModel(week: week, monthLabel: Date().monthLocalizedName())
        }
        if indexPath.row == items.count - 1 {
            loadFeatureStatistic()
        }
        return items[indexPath.row]
    }

    func saveState(for indexPath: IndexPath) {
        lastActiveCell = indexPath
    }

    func loadPastStatistic() {
        loadPastData?(dateRangeOfLoadedData.startDate)
    }

    func loadFeatureStatistic() {
        loadFeatureData?(dateRangeOfLoadedData.endDate)
    }
    // MARK: - Coordinator functions
    func insertItems(with weekItems: [StatisticWeekItem], dateRangeOfLoadedData: DateRange, showCellWith startDayOfWeek: Date?) {
        self.dateRangeOfLoadedData.update(dateRangeOfLoadedData)
        weekItems.reversed().forEach { item in
            items.insert(ChartCellViewModel(week: item, monthLabel: item.monthLabel), at: 0)
        }

        guard let startDayOfWeek = startDayOfWeek else {
            insertData?()
            return
        }
        updateUIState(with: startDayOfWeek)
    }

    func updateItems(with weekItems: [StatisticWeekItem], dataRangeOfLoadedData: DateRange) {
        let index = items.firstIndex { item in
            item.firstDayOfWeek.isTheSameDay(with: weekItems.first?.firstDayOfWeek)
        }
        guard let index = index, let item = weekItems.first else { return }
        items.remove(at: index)
        items.insert(ChartCellViewModel(week: item, monthLabel: item.monthLabel), at: index)

        reloadData?()
    }

    func addFutureItems(with weekItems: [StatisticWeekItem], dateRangeOfLoadedData: DateRange, showCellWith startDayOfWeek: Date?) {
        self.dateRangeOfLoadedData.update(dateRangeOfLoadedData)
        weekItems.forEach { item in
            items.append(ChartCellViewModel(week: item, monthLabel: item.monthLabel))
        }

        guard let startDayOfWeek = startDayOfWeek else {
            reloadData?()
            return
        }
        updateUIState(with: startDayOfWeek)
    }

    func changeLastActiveRow(with startDayOfWeek: Date) {
        let index = items.firstIndex { item in
            return item.firstDayOfWeek.isTheSameDay(with: startDayOfWeek)
        }
        lastActiveCell.row = index ?? lastActiveCell.row
    }

    private func updateUIState(with startDayOfWeek: Date) {
        changeLastActiveRow(with: startDayOfWeek)
        updateAndShowCell?(lastActiveCell)
    }
}
