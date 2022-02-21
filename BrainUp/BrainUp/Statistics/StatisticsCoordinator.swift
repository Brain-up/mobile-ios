//
//  StatisticsCoordinator.swift
//  BrainUp
//
//  Created by Evgenii Zhigunov on 2/17/22.
//

import UIKit

class StatisticsCoordinator: Coordinator, ExerciseOpener {

    private enum State {
        case emptyView
        case statisticValue
    }

    var finishDelegate: CoordinatorFinishDelegate?
    
    var childCoordinators: [Coordinator] = [Coordinator]()
    
    var navigationController: UINavigationController
    
    var type: CoordinatorType {.statistics}

    var openExercise: (() -> Void)?
    var openHelp: (() -> Void)?

    private enum StatiscticType: String, CaseIterable {
        case byWeeks = "statiscticType.byWeeks"
        case byYears = "statiscticType.byYears"
    }

    private var state: State = .emptyView
    private var currentIndex: Int = -1
    private var statisticViewController: TabBarItemViewController?

    private lazy var itemsTopView: [TopTabView] = {
        StatiscticType.allCases.enumerated().map { (index, element) in
            TopTabView(with: element.rawValue.localized.uppercased(), isActive: index == 0) { [weak self] in
                self?.action(for: index)
            }
        }
    }()

    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func calculateStartEndDates(for date: Date) -> (start: Date, end: Date) {
        let currentDate = date.currentDayWithoutTime()
        let currentWeekday = currentDate.europeanWeekDay()
        let endDate = currentDate.addDays(count: 7 - currentWeekday)
        let startDayOfWeek = currentDate.addDays(count: -(currentWeekday - 1))
        let startDate = startDayOfWeek.addDays(count: -2 * 7) // 7 - length of week

        return (startDate, endDate)
    }
    func start() {
        // network test
        let data = StatisticWeekItemsMapper.map(WeekDataMock.createData(), from: HTTPURLResponse(url: URL(string: "https://web.by")!, statusCode: 200, httpVersion: nil, headerFields: nil)!)
        switch data {
        case .success(let array):
            print(array)
        case .failure(let error):
            print("error")
        }

        let viewModel = prepareViewModel()
        let viewController = TabBarItemViewController(viewModel: viewModel)
        navigationController.viewControllers = [viewController]

        statisticViewController = viewController

        if state == .emptyView {
            startEmptyCoordinator()
        }

        // network API mock
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            guard let self = self else { return }
            // if we have something -> change state, else return
            self.state = .statisticValue
            let viewModel = self.prepareViewModel()
            viewController.update(with: viewModel)
            self.action(for: 0)
            // save data to use it in prepareCoordinators
        }
    }

    private func prepareViewModel() -> TabBarItemViewModelProtocol {
        let title = type.rawValue.localized.uppercased()
        let topTabViews: [TopTabView] = state == .statisticValue ? itemsTopView : []
        let rightBarButtons = [UIImage(named: "helpIcon")]
        var viewModel = TabBarItemViewModel(title: title, topTabViews: topTabViews, rightBarButtons: rightBarButtons)

        viewModel.rightBarbuttonAction = { [weak self] tag in
            let helpScreen = UIViewController()
            helpScreen.title = "helpScreen"
            self?.navigationController.pushViewController(helpScreen, animated: true)
            print(tag)
        }

        return viewModel
    }

    private func action(for index: Int) {
        guard currentIndex != index else { return }
        if currentIndex == -1 {
            // currentIndex equals -1 only for empty view. If we recieve data, we should remove empty view.
            childCoordinators[0].finish()
            childCoordinators.removeAll()
            prepareCoordinators()
        } else {
            // hide bottom view for previos active topTab and stop coordinator
            itemsTopView[currentIndex].updateState(isActive: false)
            childCoordinators[currentIndex].finish()
        }

        // show bottom view for active topTab and start coordinator
        itemsTopView[index].updateState(isActive: true)
        childCoordinators[index].start()

        // save index to update state in future
        currentIndex = index
    }

    private func startEmptyCoordinator() {
        guard let statisticViewController = statisticViewController else { return }
        let emptyCoordinator = EmptyStatisticCoordinator(
            rootViewController: statisticViewController,
            containerView: statisticViewController.containerView)
        emptyCoordinator.startExercisesAction = { [weak self] in
            self?.openExercise?()
        }
        childCoordinators.append(emptyCoordinator)
        emptyCoordinator.start()
    }

    private func prepareCoordinators() {
        // use data from server
        guard let statisticViewController = statisticViewController else { return }

        let weeksCoordinator = WeeksStatisticCoordinator(
            rootViewController: statisticViewController,
            containerView: statisticViewController.containerView)
        childCoordinators.append(weeksCoordinator)

        let yearsCoordinator = YearsStatisticCoordinator(
            rootViewController: statisticViewController,
            containerView: statisticViewController.containerView)
        childCoordinators.append(yearsCoordinator)
    }
}
