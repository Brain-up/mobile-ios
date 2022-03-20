//
//  YearsStatisticViewController.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 18/02/2022.
//

import UIKit

final class YearsStatisticViewController: UIViewController {
    private var collectionView: UICollectionView!
    private let refreshControl = UIRefreshControl()

    private var viewModel: YearsStatisticViewModelProtocol

    init(with viewModel: YearsStatisticViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
        setupBindings()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let visibleSectionIndexPath = collectionView.indexPathsForVisibleItems.first else { return }
        viewModel.saveState(for: visibleSectionIndexPath)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // set view alpha to 0 before showing, just to add some additional time collection view to perform scroll to last saved state
        view.alpha = 0
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.scrollToItem(at: viewModel.lastActiveSection, at: .centeredVertically, animated: false)
        view.alpha = 1
    }

    private func setupUI() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewModel.flowLayout)

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .appWhite
        collectionView.register(YearCollectionCell.self,
                                     forCellWithReuseIdentifier: YearCollectionCell.identifier)
        collectionView.register(YearCollectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: YearCollectionHeaderView.identifier)
        collectionView.register(YearCollectionFooterView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: YearCollectionFooterView.identifier)
        collectionView.isPagingEnabled = true

        refreshControl.addTarget(self, action: #selector(loadPastStatistic), for: .valueChanged)
        collectionView.refreshControl = refreshControl
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

    private func setupBindings() {
        viewModel.reloadData = { [weak self] sectionsSet in
            guard let self = self, let openedSectionIndex = sectionsSet.last else { return }
            self.refreshControl.endRefreshing()
            self.collectionView.performBatchUpdates {
                self.collectionView.insertSections(sectionsSet)
            } completion: { _ in
                self.collectionView.scrollToItem(at: IndexPath(item: 5, section: openedSectionIndex), at: .centeredVertically, animated: false)
            }
         }

        viewModel.disableLoadOldData = { [weak self] in
            self?.collectionView.refreshControl = nil
        }
    }

    @objc func loadPastStatistic() {
        viewModel.loadPastStatistic()
    }
}

extension YearsStatisticViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.openMonthStatistic(for: indexPath)
    }
}

extension YearsStatisticViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: YearCollectionCell.identifier,
            for: indexPath)
                as? YearCollectionCell  else { return UICollectionViewCell() }
        let cellViewModel = viewModel.item(for: indexPath)
        cell.configure(with: cellViewModel)
        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.sectionCount
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.itemsCount
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: YearCollectionHeaderView.identifier,
                for: indexPath)
                    as? YearCollectionHeaderView else { return UICollectionReusableView() }
            let title = viewModel.headerTitle(for: indexPath)
            headerView.configure(with: title, fontSize: viewModel.headerFontSize)
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
        return CGSize(width: collectionView.frame.width, height: viewModel.headerHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: viewModel.footerHeight)
    }
}

extension YearsStatisticViewController: UICollectionViewDelegateFlowLayout {
    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        viewModel.itemSize(for: collectionView)
    }
}
