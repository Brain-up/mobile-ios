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
    var flowLayout: UICollectionViewFlowLayout { get }
    var headerFontSize: CGFloat { get }
    var lastActiveSection: IndexPath { get }
    var reloadData: ((_ sectionsSet: IndexSet) -> Void)? { get set }
    var disableLoadOldData: (() -> Void)? { get set }

    func item(for indexPath: IndexPath) -> YearCollectionCellViewModelProtocol
    func headerTitle(for indexPath: IndexPath) -> String
    func itemSize(for collectionView: UICollectionView) -> CGSize
    func loadPastStatistic()
    func loadFeatureStatistic()
    func openMonthStatistic(for indexPath: IndexPath)
    func saveState(for indexPath: IndexPath)
}

final class YearsStatisticViewModel: YearsStatisticViewModelProtocol {
    let flowLayout: UICollectionViewFlowLayout
    let headerHeight: CGFloat = 56
    private(set) var footerHeight: CGFloat = 0
    private(set) var dataRangeOfLoadedData: DateRange = (Date(), Date())

    private let horizontalInset: CGFloat = 24
    private let lastShowedYear = 2018
    private var itemSize: CGSize = .zero
    private var isSmallGrid: Bool = true

    private(set) var lastActiveSection = IndexPath(item: 0, section: 0)

    // MARK: - Controller bindings
    var reloadData: ((IndexSet) -> Void)?
    var disableLoadOldData: (() -> Void)?

    // MARK: - Coordinator bindings
    var loadPastData: ((Date) -> Void)?
    var loadFeatureData: ((Date) -> Void)?
    var openMonthStatistic: (() -> Void)?

    private var items: [(sectionTitle: String, cellItem: [YearCollectionCellViewModelProtocol])] = []

    var sectionCount: Int {
        items.count
    }

    var itemsCount: Int {
        12 // the number of month in year
    }

    var headerFontSize: CGFloat {
        isSmallGrid ? 10 : 14
    }
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: horizontalInset, bottom: 0, right: horizontalInset)
        flowLayout = layout
    }

    func updateItems(with monthItems: [StatisticMonthItem], dataRangeOfLoadedData: DateRange) {
        update(dataRangeOfLoadedData)
        let needToAddFutureYear = items.isEmpty
        let sectionTitle = dataRangeOfLoadedData.startDate.year()
        if Int(sectionTitle) == lastShowedYear { disableLoadOldData?() }
        let monthItems = monthItems.map { item in
            YearCollectionCellViewModel(monthName: item.date.monthLocalizedName().uppercased(),
                                        timeDuration: item.exercisingTimeHours,
                                        days: item.exercisingDays, image: item.progress.monthImage,
                                        isSelected: item.date.isTheCurrentMonth(),
                                                            isSmallSize: isSmallGrid)
        }
        items.insert((sectionTitle, monthItems), at: 0)
        reloadData?([0])
        if needToAddFutureYear { loadFeatureStatistic() }
    }

    func addFutureItems(with monthItems: [StatisticMonthItem], dataRangeOfLoadedData: DateRange) {
        update(dataRangeOfLoadedData)
        let sectionTitle = dataRangeOfLoadedData.endDate.year()
        let monthItems = monthItems.map { item in
            YearCollectionCellViewModel(monthName: item.date.monthLocalizedName().uppercased(),
                                        timeDuration: item.exercisingTimeHours,
                                        days: item.exercisingDays,
                                        image: item.progress.monthImage,
                                        isSelected: item.date.isTheCurrentMonth(),
                                                            isSmallSize: isSmallGrid)
        }
        items.append((sectionTitle, monthItems))
        reloadData?([(items.count - 1)])
    }

    func item(for indexPath: IndexPath) -> YearCollectionCellViewModelProtocol {
        return items[indexPath.section].cellItem[indexPath.item]
    }

    func headerTitle(for indexPath: IndexPath) -> String {
        return items[indexPath.section].sectionTitle
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

    func saveState(for indexPath: IndexPath) {
        var middleOfCollection = indexPath
        middleOfCollection.item = 5
        lastActiveSection = middleOfCollection
    }
    
    func loadPastStatistic() {
        loadPastData?(dataRangeOfLoadedData.startDate)
    }
    
    func loadFeatureStatistic() {
        loadFeatureData?(dataRangeOfLoadedData.endDate)
    }
    
    func openMonthStatistic(for indexPath: IndexPath) {
        openMonthStatistic?()
    }

    private func update(_ dataRangeOfLoadedData: DateRange) {
        if dataRangeOfLoadedData.startDate < self.dataRangeOfLoadedData.startDate {
            self.dataRangeOfLoadedData.startDate = dataRangeOfLoadedData.startDate
        }
        if dataRangeOfLoadedData.endDate > self.dataRangeOfLoadedData.endDate {
            self.dataRangeOfLoadedData.endDate = dataRangeOfLoadedData.endDate
        }
    }
}
