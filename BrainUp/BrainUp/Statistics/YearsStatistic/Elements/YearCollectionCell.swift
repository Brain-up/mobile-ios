//
//  YearCollectionViewCell.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 07/03/2022.
//

import UIKit

class YearCollectionCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let monthNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .charcoalGrey
        label.textAlignment = .center
        return label
    }()
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .appWhite
        label.textAlignment = .center
        return label
    }()
    private let daysLabel: UILabel = {
        let label = UILabel()
        label.textColor = .appWhite
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override func prepareForReuse() {
        monthNameLabel.layer.backgroundColor = UIColor.clear.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: YearCollectionCellViewModelProtocol) {
        setupConstraints()
        imageView.image = viewModel.image
        monthNameLabel.text = viewModel.monthName
        timeLabel.text = viewModel.timeDuration
        daysLabel.attributedText = viewModel.dayDuration
        monthNameLabel.font = UIFont.montserratSemiBold(size: viewModel.fontSize)
        timeLabel.font = UIFont.montserratSemiBold(size: viewModel.fontSize)

        if viewModel.isSelected {
            monthNameLabel.layer.backgroundColor = UIColor.warmViolet.cgColor
            monthNameLabel.layer.cornerRadius = 6
        }
    }

    private func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 0)
        ])

        monthNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(monthNameLabel)
        NSLayoutConstraint.activate([
            monthNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            monthNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            monthNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 6),
            monthNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])

        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(timeLabel)
        NSLayoutConstraint.activate([
            timeLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 0),
            timeLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 0),
            timeLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: -2)
        ])

        daysLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(daysLabel)
        NSLayoutConstraint.activate([
            daysLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 0),
            daysLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 0),
            daysLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 3)
        ])
    }
}
