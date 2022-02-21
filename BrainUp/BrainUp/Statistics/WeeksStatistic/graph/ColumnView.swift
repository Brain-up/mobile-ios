//
//  ColumnView.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 21/02/2022.
//

import UIKit

protocol ColumnViewModelProtocol {
    var columnHeight: CGFloat { get }
    var columnWidth: CGFloat { get }
    var columnColor: UIColor { get }
    var timeColor: UIColor { get }

    var time: String { get }
}

struct ColumnViewModel: ColumnViewModelProtocol {
    let columnHeight: CGFloat
    var columnWidth: CGFloat = 16
    let columnColor: UIColor
    let timeColor: UIColor
    let time: String
}

class ColumnView: UIView {
    let stackView = UIStackView()
    let timeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.montserratSemiBold(size: 9)
        return label
    }()
    let columnView = UIView()

    private let viewModel: ColumnViewModelProtocol

    init(with viewModel: ColumnViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)

        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        timeLabel.text = viewModel.time
        timeLabel.textColor = viewModel.timeColor

        columnView.backgroundColor = viewModel.columnColor
        columnView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        columnView.layer.cornerRadius = 8
        columnView.clipsToBounds = true

        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.spacing = 0
    }

    private func setupConstraints() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

        stackView.addArrangedSubview(timeLabel)
        stackView.addArrangedSubview(columnView)

        columnView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            columnView.widthAnchor.constraint(equalToConstant: viewModel.columnWidth),
            columnView.heightAnchor.constraint(equalToConstant: viewModel.columnHeight)
        ])
        columnView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    }
}
