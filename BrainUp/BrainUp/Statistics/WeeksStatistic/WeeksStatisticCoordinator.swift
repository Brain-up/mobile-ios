//
//  WeeksStatisticCoordinator.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 18/02/2022.
//

import UIKit

class WeeksStatisticCoordinator: TopTabItemCoordinator {
    private let networkService: NetworkService
    // property injection for test purpose. If we consider separate architecture in modules, we could inject this properties inside init method.
    var mapper = StatisticWeekItemsMapper()
    var helper: StatisticDateHelperProtocol.Type = StatisticDateHelper.self

    init(rootViewController: UIViewController, containerView: UIView, networkService: NetworkService) {
        self.networkService = networkService
        super.init(rootViewController: rootViewController, containerView: containerView)
    }

    required init(_ navigationController: UINavigationController) {
        preconditionFailure("init(_:) has not been implemented")
    }

    override func start() {
        let viewModel = WeeksStatisticViewModel()
        let dateRange = helper.calculateStartEndDates(for: Date())
        mapper.fetch(for: dateRange, with: networkService) { result in
            switch result {
            case let .success(items):
                viewModel.updateItems(with: items)
            case .failure:
                // error handler?
                break
            }
        }
        let viewController = WeeksStatisticViewController(with: viewModel)
        addToContainer(controller: viewController)
    }
}
