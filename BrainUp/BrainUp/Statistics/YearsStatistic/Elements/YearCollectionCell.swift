//
//  YearCollectionViewCell.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 07/03/2022.
//

import UIKit
protocol YearCollectionCellViewModelProtocol {
    var monthName: String { get }
    var timeDuration: String { get }
    var dayDuration: NSAttributedString { get }
    var image: UIImage? { get }
    var isSelected: Bool { get }
    var fontSize: CGFloat { get }
}

struct YearCollectionCellViewModel: YearCollectionCellViewModelProtocol {
    let monthName: String
    let timeDuration: String
    let image: UIImage?
    let isSelected: Bool
    let fontSize: CGFloat

    private(set) var dayDuration: NSAttributedString = NSAttributedString()

    init(monthName: String, timeDuration: String, days: Int, image: UIImage?, isSelected: Bool, isSmallSize: Bool) {
        self.monthName = monthName
        self.timeDuration = timeDuration
        self.image = image
        self.isSelected = isSelected
        self.fontSize = isSmallSize ? 10 : 14
        dayDuration = dayDuration(for: days)
    }

    private func dayDuration(for number: Int) -> NSAttributedString {
        let baseString = baseDaysString(for: number)
        let daysString = String(number)
        let updatedString = baseString.replacingOccurrences(of: "{count}", with: daysString)
        let daysRange = (updatedString as NSString).range(of: daysString)

        let attributedString = NSMutableAttributedString(string: updatedString, attributes: [.font: UIFont.montserratRegular(size: fontSize)])

        attributedString.setAttributes([.font: UIFont.montserratSemiBold(size: fontSize)], range: daysRange)
        return attributedString
    }

    private func baseDaysString(for number: Int) -> String {
        guard number != 11 else { return "за {count} дней" }
        let lastNumber = number % 10
        switch lastNumber {
        case 1:
            return "за {count} день"
        case 2, 3, 4:
            return "за {count} дня"
        default:
            return "за {count} дней"
        }
    }
}
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
