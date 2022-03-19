//
//  YearCollectionCellViewModel.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 19/03/2022.
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
        guard number != 11 else { return "statisctic.plural_days_spent".localized }
        guard number != 1 else { return "statisctic.singular_day_spent".localized }
        let lastNumber = number % 10
        switch lastNumber {
        case 1:
            return "statisctic.day_end_by_one_spent".localized
        case 2, 3, 4:
            return "statisctic.two_trhee_four_days_spent".localized
        default:
            return "statisctic.plural_days_spent".localized
        }
    }
}
