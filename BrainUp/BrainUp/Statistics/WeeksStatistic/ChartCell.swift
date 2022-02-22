//
//  ChartCell.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 21/02/2022.
//

import UIKit

protocol ChartCellViewModelProtocol {
    var chartViewModel: GraphicViewModelProtocol { get }
    var legendViewModel: LegendViewModelProtocol { get }
    var monthLabel: String { get }
}

struct ChartCellViewModel: ChartCellViewModelProtocol {
    let chartViewModel: GraphicViewModelProtocol = GraphicViewModel()
    let legendViewModel: LegendViewModelProtocol = LegendViewModel()
    let monthLabel: String = "Месяц"
}

class ChartCell: UITableViewCell {
    private var chartView: GraphicView!
    private var legendView: LegendView!
    private let monthLabel: UILabel = {
        let label = UILabel()
        label.textColor = .charcoalGrey
        label.textAlignment = .natural
        label.font = UIFont.montserratSemiBold(size: 10)
        return label
    }()

    private var viewModel: ChartCellViewModelProtocol!

    override func prepareForReuse() {
        super.prepareForReuse()
        monthLabel.text = ""
        chartView.removeFromSuperview()
        legendView.removeFromSuperview()
        monthLabel.removeFromSuperview()
    }

    func configure(with viewModel: ChartCellViewModelProtocol) {
        self.viewModel = viewModel
        chartView = GraphicView(with: viewModel.chartViewModel)
        legendView = LegendView(with: viewModel.legendViewModel)
        setupUI()
        setupConstraints()
    }
    
    private func  setupUI() {
        monthLabel.text = viewModel.monthLabel.uppercased()
    }

    private func setupConstraints() {
        chartView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(chartView)
        NSLayoutConstraint.activate([
            chartView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 44),
            chartView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 24)
        ])

        let lineView = UIView()
        lineView.backgroundColor = .red
        lineView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(lineView)
        NSLayoutConstraint.activate([
            lineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            lineView.topAnchor.constraint(equalTo: chartView.bottomAnchor, constant: 0),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.trailingAnchor.constraint(equalTo: chartView.trailingAnchor, constant: 12)
        ])

        legendView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(legendView)
        NSLayoutConstraint.activate([
            legendView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 44),
            legendView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 0),
            legendView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            legendView.trailingAnchor.constraint(equalTo: chartView.trailingAnchor)
        ])

        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(monthLabel)
        NSLayoutConstraint.activate([
            monthLabel.leadingAnchor.constraint(equalTo: lineView.trailingAnchor, constant: 14),
            monthLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            monthLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
    }
}
