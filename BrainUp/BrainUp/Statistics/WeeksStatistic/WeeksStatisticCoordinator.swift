//
//  WeeksStatisticCoordinator.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 18/02/2022.
//

import UIKit

class WeeksStatisticCoordinator: TopTabItemCoordinator {
    private let networkService: NetworkService
    private let viewModel = WeeksStatisticViewModel()
    private var dataIsFetched = false
    private var startDayOfWeekForPresenting: Date?
    private var shouldFetch = true
    // property injection for test purpose. If we consider separate architecture in modules, we could inject this properties inside init method.
    var mapper: StatisticWeekItemsMapperProtocol = StatisticWeekItemsMapper()
    var helper: StatisticDateHelperProtocol.Type = StatisticDateHelper.self
    var startDateToOpen: Date?

    init(rootViewController: UIViewController, containerView: UIView, networkService: NetworkService) {
        self.networkService = networkService
        super.init(rootViewController: rootViewController, containerView: containerView)
    }

    required init(_ navigationController: UINavigationController) {
        preconditionFailure("init(_:) has not been implemented")
    }

    override func start() {
        viewModel.loadPastData = { [weak self] firstDayOfLoadedData in
            guard let self = self else { return }
            let lastDayOfNewData = firstDayOfLoadedData.addDays(count: -1)
            
            self.fetchStatistic(forDate: lastDayOfNewData)
        }

        viewModel.loadFeatureData = { [weak self] lastDayOfLoadedData in
            guard let self = self else { return }
            let firstDayOfNewData = lastDayOfLoadedData.addDays(count: 1)
            self.fetchStatistic(forDate: firstDayOfNewData)
        }

        if let datesRanges = newDatesToFetch() {
            fetchStatistic(for: datesRanges.dateRangeString, dateRange: datesRanges.dateRange, isUpdating: false)
        } else if shouldFetch {
            let today = Date()
            let numberOfWeeksToAdd = dataIsFetched ? 0 : 2
            fetchStatistic(forDate: today, numberOfWeeksToAdd: numberOfWeeksToAdd, isUpdating: dataIsFetched)
        }
        let viewController = WeeksStatisticViewController(with: viewModel)
        addToContainer(controller: viewController)
        shouldFetch = true
    }

    private func newDatesToFetch() -> (dateRangeString: DateRangeString, dateRange: DateRange)? {
        guard let startDate = startDateToOpen else {
            return nil
        }
        let fetchedDateRange = viewModel.dateRangeOfLoadedData
        let startDateToOpen = helper.firstDayOfWeek(for: startDate)
        var adjustedDateRange = DateRange(startDate: startDateToOpen, endDate: startDateToOpen)
        startDayOfWeekForPresenting = startDateToOpen

        self.startDateToOpen = nil

        if startDateToOpen < fetchedDateRange.startDate {
            adjustedDateRange.endDate = fetchedDateRange.startDate.addDays(count: -1)
        } else if startDateToOpen > fetchedDateRange.endDate {
            adjustedDateRange.startDate = fetchedDateRange.endDate.addDays(count: 1)
            adjustedDateRange.endDate = startDateToOpen.addDays(count: 7 * 5) // 7 is week, 5 is highest month duration
        } else if startDateToOpen > fetchedDateRange.startDate {
            shouldFetch = false
            viewModel.changeLastActiveRow(with: startDayOfWeekForPresenting ?? Date())
            startDayOfWeekForPresenting = nil
            return nil
        }
        let adjustedDateRangeString = helper.dateRangeString(from: adjustedDateRange)
        return (adjustedDateRangeString, adjustedDateRange)
    }

    private func fetchStatistic(forDate date: Date, numberOfWeeksToAdd: Int = 2, isUpdating: Bool = false) {
        if date.isFutureDay() {
            fetchEmptyStatistic(forDate: date)
            return
        }
        let (dateRangeString, dateRange) = helper.calculateStartEndDates(for: date, numberOfWeeksToAdd: numberOfWeeksToAdd)
        fetchStatistic(for: dateRangeString, dateRange: dateRange, isUpdating: isUpdating)
    }

    private func fetchStatistic(for dateRangeString: DateRangeString, dateRange: DateRange, isUpdating: Bool) {
        if dateRange.startDate.isFutureDay() {
            fetchEmptyStatistic(for: dateRangeString, dateRange: dateRange)
            return
        }
        mapper.fetch(for: dateRangeString, with: networkService) { [weak self] result in
            switch result {
            case let .success(items):
                if isUpdating {
                    self?.viewModel.updateItems(with: items, dataRangeOfLoadedData: dateRange)
                    return
                }
                self?.viewModel.insertItems(with: items, dateRangeOfLoadedData: dateRange, showCellWith: self?.startDayOfWeekForPresenting)
                self?.startDayOfWeekForPresenting = nil
                self?.dataIsFetched = true
            case .failure:
                // error handler?
                break
            }
        }
    }

    private func fetchEmptyStatistic(forDate date: Date) {
        let (dateRangeString, dateRange) = helper.calculateStartEndDatesForFutureItems(for: date)
        fetchEmptyStatistic(for: dateRangeString, dateRange: dateRange)
    }

    private func fetchEmptyStatistic(for dateRangeString: DateRangeString, dateRange: DateRange) {
        mapper.fetchFutureItems(for: dateRangeString) { [weak self] result in
            switch result {
            case let .success(items):
                self?.viewModel.addFutureItems(with: items, dateRangeOfLoadedData: dateRange, showCellWith: self?.startDayOfWeekForPresenting)
                self?.startDayOfWeekForPresenting = nil
            case .failure:
                // error handler?
                break
            }
        }
    }
}
