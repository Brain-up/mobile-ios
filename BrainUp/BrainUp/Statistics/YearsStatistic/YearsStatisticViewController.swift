//
//  YearsStatisticViewController.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 18/02/2022.
//

import UIKit

final class YearsStatisticViewController: UIViewController {
    let data = [UIColor.red, UIColor.yellow, UIColor.green, UIColor.gray, UIColor.red, UIColor.yellow, UIColor.green, UIColor.gray, UIColor.red, UIColor.yellow, UIColor.green, UIColor.gray]

    private var collectionView: UICollectionView!
    private let headerHeight: CGFloat = 56
    private let horizontalInset: CGFloat = 24
    private let bottomInset: CGFloat = 0
    private var footerHeight: CGFloat = 0
    private var itemSize: CGSize = .zero

    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        return layout
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupConstraints()
    }

    private func setupCollectionView() {
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: horizontalInset, bottom: bottomInset, right: horizontalInset)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .appWhite
        collectionView.register(YearCollectionViewCell.self,
                                     forCellWithReuseIdentifier: YearCollectionViewCell.identifier)
        collectionView.register(YearCollectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: YearCollectionHeaderView.identifier)
        collectionView.register(YearCollectionFooterView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: YearCollectionFooterView.identifier)
        collectionView.isPagingEnabled = true
    }

    private func setupConstraints() {
        // there is issue: if collection the first subview, largeTitle will shrimp. This behavior break all our UI composition.
        let crunchView = UIView()
        crunchView.backgroundColor = .clear
        crunchView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(crunchView)
        crunchView.backgroundColor = .clear
        NSLayoutConstraint.activate([
            crunchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            crunchView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            crunchView.topAnchor.constraint(equalTo: view.topAnchor),
            crunchView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension YearsStatisticViewController: UICollectionViewDelegate {
    // if the user clicks on a cell, display a message
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }
}

extension YearsStatisticViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: YearCollectionViewCell.identifier,
            for: indexPath)
                as? YearCollectionViewCell  else { return UICollectionViewCell() }
        let data = self.data[indexPath.item]
        cell.setupCell(colour: data)
        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: YearCollectionHeaderView.identifier,
                for: indexPath)
                    as? YearCollectionHeaderView else { return UICollectionReusableView() }
            headerView.configure(with: data[indexPath.section].description)
            return headerView
        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: YearCollectionFooterView.identifier,
                for: indexPath)
            return footerView
        default:
            assert(false, "Unexpected element kind")
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: headerHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: footerHeight)
    }
}

extension YearsStatisticViewController: UICollectionViewDelegateFlowLayout {
    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
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

        if itemHeight < minItemHeight || itemWidth * maxNumberOfItems <= availableWidth {
            // layout elements in grid 4x3
            itemWidth = floor(availableWidth / maxNumberOfItems)
            itemHeight = floor(itemWidth * aspectRatio)
            footerHeight = height - (itemHeight * 3 + spacing * 2) // 3 items in colomn 2 spaces between
        }

        itemSize = CGSize(width: itemWidth, height: itemHeight)
        return itemSize
    }
}


