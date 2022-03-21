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
    var insertData: ((_ sectionsSet: IndexSet) -> Void)? { get set }
    var reloadData: (() -> Void)? { get set }
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
    private let horizontalInset: CGFloat = 24
    private let lastShowedYear = 2018
    private var itemSize: CGSize = .zero
    private var isSmallGrid: Bool = true
    private var dateRangeOfLoadedData = DateRange(startDate: Date(), endDate: Date())
    private var items: [(sectionTitle: String, cellItem: [YearCollectionCellViewModelProtocol])] = []

    // MARK: - Coordinator bindings
    var loadPastData: ((Date) -> Void)?
    var loadFeatureData: ((Date) -> Void)?
    var openMonthStatistic: ((_ startDateOfMonth: Date) -> Void)?

    // MARK: - YearsStatisticViewModelProtocol
    var insertData: ((IndexSet) -> Void)?
    var reloadData: (() -> Void)?
    var disableLoadOldData: (() -> Void)?

    let flowLayout: UICollectionViewFlowLayout
    let headerHeight: CGFloat = 56
    private(set) var footerHeight: CGFloat = 0
    private(set) var lastActiveSection = IndexPath(item: 0, section: 0)

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
        loadPastData?(dateRangeOfLoadedData.startDate)
    }
    
    func loadFeatureStatistic() {
        loadFeatureData?(dateRangeOfLoadedData.endDate)
    }
    
    func openMonthStatistic(for indexPath: IndexPath) {
        let startDate = items[indexPath.section].cellItem[indexPath.item].startDate
        openMonthStatistic?(startDate)
    }
    // MARK: - Coordinator functions
    func insertItems(with monthItems: [StatisticMonthItem], dateRangeOfLoadedData: DateRange) {
        self.dateRangeOfLoadedData.update(dateRangeOfLoadedData)
        let needToAddFutureYear = items.isEmpty
        let sectionTitle = dateRangeOfLoadedData.startDate.year()
        if Int(sectionTitle) == lastShowedYear { disableLoadOldData?() }
        let monthItems = createCell(for: monthItems)
        items.insert((sectionTitle, monthItems), at: 0)
        insertData?([0])
        if needToAddFutureYear { loadFeatureStatistic() }
    }

    func updateItems(with monthItems: [StatisticMonthItem], dateRangeOfLoadedData: DateRange) {
        let sectionTitle = dateRangeOfLoadedData.startDate.year()
        let itemsIndex = items.firstIndex { $0.sectionTitle == sectionTitle }
        guard let itemsIndex = itemsIndex else { return }
        let monthItems = createCell(for: monthItems)
        items.remove(at: itemsIndex)
        items.insert((sectionTitle, monthItems), at: itemsIndex)
        reloadData?()
    }

    func addFutureItems(with monthItems: [StatisticMonthItem], dateRangeOfLoadedData: DateRange) {
        self.dateRangeOfLoadedData.update(dateRangeOfLoadedData)
        let sectionTitle = dateRangeOfLoadedData.endDate.year()
        let monthItems = createCell(for: monthItems)
        items.append((sectionTitle, monthItems))
        insertData?([(items.count - 1)])
    }

    private func createCell(for monthItems: [StatisticMonthItem]) -> [YearCollectionCellViewModelProtocol] {
        monthItems.map { item in
            YearCollectionCellViewModel(startDate: item.date,
                                        timeDuration: item.exercisingTimeHours,
                                        days: item.exercisingDays,
                                        image: item.progress.monthImage,
                                        isSelected: item.date.isTheCurrentMonth(),
                                                            isSmallSize: isSmallGrid)
        }
    }
}
