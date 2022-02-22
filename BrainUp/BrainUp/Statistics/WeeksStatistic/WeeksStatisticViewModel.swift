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

    func loadMoreStatistic()
}

class WeeksStatisticViewModel: WeeksStatisticViewModelProtocol {
    var items: [ChartCellViewModelProtocol] = [
        ChartCellViewModel(),
        ChartCellViewModel(),
        ChartCellViewModel()
    ]
    var reloadData: (() -> Void)?

    func loadMoreStatistic() {
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 3) { [weak self] in
            self?.items.insert(ChartCellViewModel(), at: 0)
            self?.items.insert(ChartCellViewModel(), at: 0)
            self?.items.insert(ChartCellViewModel(), at: 0)
            self?.reloadData?()
        }
    }

    var numberOfRows: Int {
        items.count
    }

    func item(for indexPath: IndexPath) -> ChartCellViewModelProtocol {
        return ChartCellViewModel()
    }
}
