//
//  YearsStatisticViewModel.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 12/03/2022.
//

import UIKit

protocol YearsStatisticViewModelProtocol {
    var sectionCount: Int { get }
    var itemsCount: Int { get }
    var footerHeight: CGFloat { get }
    var headerHeight: CGFloat { get }
//    var horizontalInset: CGFloat { get }
    var flowLayout: UICollectionViewFlowLayout { get }
    var reloadData: ((_ sectionsSet: IndexSet) -> Void)? { get set }
    var disableLoadOldData: (() -> Void)? { get set }

    func item(for indexPath: IndexPath) -> YearCollectionCellViewModelProtocol
    func headerTitle(for indexPath: IndexPath) -> String
    func itemSize(for collectionView: UICollectionView) -> CGSize
    func loadPastStatistic()
    func loadFeatureStatistic()
    func openMonthStatistic(for indexPath: IndexPath)
}

final class YearsStatisticViewModel: YearsStatisticViewModelProtocol {
    let flowLayout: UICollectionViewFlowLayout
    let headerHeight: CGFloat = 56
    let horizontalInset: CGFloat = 24
    private(set) var footerHeight: CGFloat = 0
    private var itemSize: CGSize = .zero
    private var isSmallGrid: Bool = true
    private(set) var dataRangeOfLoadedData: DateRange = (Date(), Date())

    // MARK: - Controller bindings
    var reloadData: ((IndexSet) -> Void)?
    var disableLoadOldData: (() -> Void)?

    // MARK: - Coordinator bindings
    var loadPastData: ((Date) -> Void)?
    var loadFeatureData: ((Date) -> Void)?
    var openMonthStatistic: (() -> Void)?

    private var data: [(sectionTitle: String, cellItem: [YearCollectionCellViewModelProtocol])] = []

    var sectionCount: Int {
        data.count
    }

    var itemsCount: Int {
        12
    }
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: horizontalInset, bottom: 0, right: horizontalInset)
        flowLayout = layout
//        data = [createCellItems(sectionTitle: "2022")]
    }

    func updateItems(with monthItems: [StatisticMonthItem], dataRangeOfLoadedData: DateRange) {
        update(dataRangeOfLoadedData)
        let sectionTitle = dataRangeOfLoadedData.startDate.year()
        let items = monthItems.map { item in
            YearCollectionCellViewModel(monthName: item.date.monthLocalizedName().uppercased(),
                                        timeDuration: item.exercisingTimeHours,
                                        days: item.exercisingDays, image: item.progress.monthImage,
                                        isSelected: item.date.isTheCurrentMonth(),
                                                            isSmallSize: isSmallGrid)
        }
        data.append((sectionTitle, items))
        reloadData?([0])
    }

    func addFutureItems(with monthItems: [StatisticMonthItem], dataRangeOfLoadedData: DateRange) {
        update(dataRangeOfLoadedData)
//        monthItems.forEach { item in
//            items.append(ChartCellViewModel(week: item, monthLabel: item.monthLabel))
//        }
//        reloadData?()
    }

    private func createCellItems(sectionTitle: String) -> (sectionTitle: String, cellItem: [YearCollectionCellViewModelProtocol]) {
        let items = LocalizedMonthName.allCases.enumerated().map { index, month in
            YearCollectionCellViewModel(monthName: month.rawValue.localized.uppercased(),
                                                            timeDuration: "1:23:\(index)",
                                                            days: index, image: StatisticProgress.bad.monthImage,
                                                            isSelected: true,
                                                            isSmallSize: isSmallGrid)
        }
        return (sectionTitle, items)
    }

    func item(for indexPath: IndexPath) -> YearCollectionCellViewModelProtocol {
        data[indexPath.section].cellItem[indexPath.item]
    }

    func headerTitle(for indexPath: IndexPath) -> String {
        return data[indexPath.section].sectionTitle
    }

    func itemSize(for collectionView: UICollectionView) -> CGSize {
        guard itemSize == .zero else { return itemSize }
        let width = collectionView.bounds.width - horizontalInset * 2
        let height = collectionView.bounds.height - headerHeight
        let maxNumberOfItems: CGFloat = 4
        let minItemHeight: CGFloat = 86
        let aspectRatio: CGFloat = 1.3
        let spacing: CGFloat = flowLayout.minimumInteritemSpacing

        let availableHeight = height - spacing * (maxNumberOfItems - 1)
        let availableWidth = width - spacing * (maxNumberOfItems - 1)
        // try to layout elements in grid 3x4
        var itemHeight = floor(availableHeight / maxNumberOfItems)
        var itemWidth = floor(itemHeight / aspectRatio)

        footerHeight = height - (itemHeight * maxNumberOfItems + spacing * (maxNumberOfItems - 1))
        isSmallGrid = false
        if itemHeight < minItemHeight || itemWidth * maxNumberOfItems <= availableWidth {
            // layout elements in grid 4x3
            itemWidth = floor(availableWidth / maxNumberOfItems)
            itemHeight = floor(itemWidth * aspectRatio)
            footerHeight = height - (itemHeight * 3 + spacing * 2) // 3 items in colomn 2 spaces between
            isSmallGrid = true
        }

        itemSize = CGSize(width: itemWidth, height: itemHeight)
        return itemSize
    }
    
    func loadPastStatistic() {
        let items1 = createCellItems(sectionTitle: "2021")
        let items2 = createCellItems(sectionTitle: "2020")
        data.insert(items1, at: 0)
        data.insert(items2, at: 0)

        reloadData?([0, 1])
        disableLoadOldData?()
    }
    
    func loadFeatureStatistic() {
        //
    }
    
    func openMonthStatistic(for indexPath: IndexPath) {
        openMonthStatistic?()
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
