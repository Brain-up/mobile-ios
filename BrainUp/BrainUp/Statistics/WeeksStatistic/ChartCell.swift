//
//  ChartCell.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 21/02/2022.
//

import UIKit

protocol ChartCellViewModelProtocol {
    var chartViewModel: GraphicViewModelProtocol { get }
    var monthLabel: String { get }
}

struct ChartCellViewModel: ChartCellViewModelProtocol {
    let chartViewModel: GraphicViewModelProtocol = GraphicViewModel()
    let monthLabel: String = "Месяц"
}

class ChartCell: UITableViewCell {
    private var chartView: GraphicView!
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
        monthLabel.removeFromSuperview()
    }

    func configure(with viewModel: ChartCellViewModelProtocol) {
        self.viewModel = viewModel
        chartView = GraphicView(with: viewModel.chartViewModel)
        setupUI()
        setupConstraints()
    }
    
    private func  setupUI() {
        monthLabel.text = viewModel.monthLabel
    }

    private func setupConstraints() {
        chartView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(chartView)
        NSLayoutConstraint.activate([
            chartView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            chartView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            chartView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])

        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(monthLabel)
        NSLayoutConstraint.activate([
            monthLabel.leadingAnchor.constraint(equalTo: chartView.trailingAnchor, constant: 14),
            monthLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            monthLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
    }
}
