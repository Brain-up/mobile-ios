//
//  WeeksStatisticViewController.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 18/02/2022.
//

import UIKit
protocol WeeksStatisticViewModelProtocol {
    func item(for indexPath: IndexPath) -> ChartCellViewModelProtocol
    var numberOfRows: Int { get }
}
struct WeeksStatisticViewModel: WeeksStatisticViewModelProtocol {
    var numberOfRows: Int {
        10
    }

    func item(for indexPath: IndexPath) -> ChartCellViewModelProtocol {
        return ChartCellViewModel()
    }
}

final class WeeksStatisticViewController: UIViewController {
    private let tableView = UITableView()
    private let viewModel: WeeksStatisticViewModelProtocol

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
    }

    private func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ChartCell.self, forCellReuseIdentifier: ChartCell.identifier)
//
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 300
        tableView.backgroundColor = .cyan
        tableView.separatorStyle = .none
//        tableView.bounces = false
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
}
// MARK: - Table view data source
extension WeeksStatisticViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        140
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cellClass: ChartCell.self, forIndexPath: indexPath)
        cell.configure(with: viewModel.item(for: indexPath))
        return cell
    }
}
// MARK: - UITableViewDelegate.
extension WeeksStatisticViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
