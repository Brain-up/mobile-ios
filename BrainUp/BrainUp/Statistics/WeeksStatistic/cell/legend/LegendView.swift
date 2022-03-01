//
//  LegendView.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 22/02/2022.
//

import UIKit

final class LegendView: UIView {
    let horizontalStackView = UIStackView()

    private let viewModel: LegendViewModelProtocol

    init(with viewModel: LegendViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)

        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .center
        horizontalStackView.distribution = .fillEqually
    }

    private func setupConstraints() {
        addSubview(horizontalStackView)
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            horizontalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            horizontalStackView.topAnchor.constraint(equalTo: self.topAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

        viewModel.items.forEach { element in
            let weekDayLabel = createWeekDayLabel()
            weekDayLabel.text = element.weekday
            let dateLabel = createDateLabel()
            dateLabel.text = element.date

            if element.isSelected {
                dateLabel.layer.backgroundColor = UIColor.warmViolet.cgColor
                dateLabel.layer.cornerRadius = 6
            }

            if element.isFutureDay {
                dateLabel.textColor = .mouseGrey
            }

            let stackView = createVerticalStack()
            stackView.addArrangedSubview(weekDayLabel)
            stackView.addArrangedSubview(dateLabel)

            horizontalStackView.addArrangedSubview(stackView)
        }
    }

    private func createVerticalStack() -> UIStackView {
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .center
        verticalStackView.distribution = .fillProportionally
        verticalStackView.spacing = 2
        return verticalStackView
    }

    private func createWeekDayLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .activeGray
        label.font = UIFont.montserratRegular(size: 10)
        return label
    }

    private func createDateLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.montserratSemiBold(size: 10)
        label.textColor = .charcoalGrey // mouse gray
        return label
    }
}
