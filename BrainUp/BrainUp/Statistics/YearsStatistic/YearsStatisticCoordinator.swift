//
//  YearsStatisticCoordinator.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 18/02/2022.
//

import UIKit

class YearsStatisticCoordinator: TopTabItemCoordinator {
    private let networkService: NetworkService
    private let viewModel = YearsStatisticViewModel()
    private var dataIsFetched = false
    // property injection for test purpose. If we consider separate architecture in modules, we could inject this properties inside init method.
    var mapper = StatisticYearItemsMapper()
    var helper: StatisticDateHelperProtocol.Type = StatisticDateHelper.self
    var openMonthStatistic: ((_ startDateOfMonth: Date) -> Void)?

    init(rootViewController: UIViewController, containerView: UIView, networkService: NetworkService) {
        self.networkService = networkService
        super.init(rootViewController: rootViewController, containerView: containerView)
    }

    required init(_ navigationController: UINavigationController) {
        preconditionFailure("init(_:) has not been implemented")
    }

    override func start() {
        viewModel.openMonthStatistic = openMonthStatistic
        viewModel.loadPastData = { [weak self] firstYearLoadedData in
            guard let self = self else { return }
            let lastDayOfNewData = firstYearLoadedData.addYears(count: -1)
            self.fetchStatistic(for: lastDayOfNewData, isUpdating: false)
        }

        viewModel.loadFeatureData = { [weak self] lastDayOfLoadedData in
            guard let self = self else { return }
            let firstDayOfNewData = lastDayOfLoadedData.addDays(count: 1)
            self.fetchStatistic(for: firstDayOfNewData, isUpdating: false)
        }
        let today = Date()
        fetchStatistic(for: today, isUpdating: dataIsFetched)
        let viewController = YearsStatisticViewController(with: viewModel)
        addToContainer(controller: viewController)
    }

    private func fetchStatistic(for date: Date, isUpdating: Bool) {
        if date.isFutureDay() {
            fetchEmptyStatistic(for: date)
            return
        }

        let (dateRangeString, dateRange) = helper.calculateStartEndYearDates(for: date)
        mapper.fetch(for: dateRangeString, with: networkService) { [weak self] result in
            switch result {
            case let .success(items):
                if isUpdating {
                    self?.viewModel.updateItems(with: items, dateRangeOfLoadedData: dateRange)
                    return
                }
                self?.viewModel.insertItems(with: items, dateRangeOfLoadedData: dateRange)
                self?.dataIsFetched = true
            case .failure:
                // error handler?
                break
            }
        }
    }

    private func fetchEmptyStatistic(for date: Date) {
        let (dateRangeString, dateRange) = helper.calculateStartEndYearDatesForFutureItems(for: date)
        mapper.fetchFutureItems(for: dateRangeString) { [weak self] result in
            switch result {
            case let .success(items):
                self?.viewModel.addFutureItems(with: items, dateRangeOfLoadedData: dateRange)
            case .failure:
                // error handler?
                break
            }
        }
    }

}
