//
//  WeeksStatisticViewController.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 18/02/2022.
//

import UIKit

final class WeeksStatisticViewController: UIViewController {
    private let rowHeight: CGFloat = 140

    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    private var viewModel: WeeksStatisticViewModelProtocol

    init(with viewModel: WeeksStatisticViewModelProtocol) {
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

    private func setupUI() {
        tableView.dataSource = self

        tableView.register(ChartCell.self, forCellReuseIdentifier: ChartCell.identifier)
        tableView.separatorStyle = .none

        refreshControl.addTarget(self, action: #selector(loadPastStatistic), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    private func setupConstraints() {
        // there is issue: if tableView the first subview, largeTitle will shrimp. This behavior break all our UI composition.
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

        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        view.backgroundColor = .clear
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupBindings() {
        viewModel.reloadData = { [weak self] in
            guard let self = self else { return }
            let oldContentHeight: CGFloat = self.tableView.contentSize.height
            let oldOffsetY: CGFloat = self.tableView.contentOffset.y

            self.tableView.reloadData()

            let newContentHeight: CGFloat = self.tableView.contentSize.height
            self.tableView.contentOffset.y = oldOffsetY + (newContentHeight - oldContentHeight)

            self.refreshControl.endRefreshing()
         }
    }

    @objc func loadPastStatistic() {
        viewModel.loadPastStatistic()
    }
}
// MARK: - Table view data source
extension WeeksStatisticViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        rowHeight
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cellClass: ChartCell.self, forIndexPath: indexPath)
        let cellViewModel = viewModel.item(for: indexPath)
        cell.configure(with: cellViewModel)
        return cell
    }
}
