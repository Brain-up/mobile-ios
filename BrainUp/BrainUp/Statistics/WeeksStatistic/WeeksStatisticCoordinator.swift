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
    // property injection for test purpose. If we consider separate architecture in modules, we could inject this properties inside init method.
    var mapper: StatisticWeekItemsMapperProtocol = StatisticWeekItemsMapper()
    var helper: StatisticDateHelperProtocol.Type = StatisticDateHelper.self

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
            self.fetchStatistic(for: lastDayOfNewData)
        }

        viewModel.loadFeatureData = { [weak self] lastDayOfLoadedData in
            let firstDayOfNewData = lastDayOfLoadedData.addDays(count: 1)
            self?.fetchStatistic(for: firstDayOfNewData)
        }

        let today = Date()
        fetchStatistic(for: today)
        let viewController = WeeksStatisticViewController(with: viewModel)
        addToContainer(controller: viewController)
    }

    private func fetchStatistic(for date: Date) {
        if date.isFutureDay() {
            fetchEmptyStatistic(for: date)
            return
        }

        let (dateRangeString, dateRange) = helper.calculateStartEndDates(for: date)
        mapper.fetch(for: dateRangeString, with: networkService) { [weak self] result in
            switch result {
            case let .success(items):
                self?.viewModel.updateItems(with: items, dataRangeOfLoadedData: dateRange)
            case .failure:
                // error handler?
                break
            }
        }
    }

    private func fetchEmptyStatistic(for date: Date) {
        let (dateRangeString, dateRange) = helper.calculateStartEndDatesForFutureItems(for: date)
        mapper.fetchFutureItems(for: dateRangeString) { [weak self] result in
            switch result {
            case let .success(items):
                self?.viewModel.addEmptyItems(with: items, dataRangeOfLoadedData: dateRange)
            case .failure:
                // error handler?
                break
            }
        }
    }
}
