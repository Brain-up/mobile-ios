//
//  StatisticProgress.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 24/02/2022.
//

import UIKit

enum StatisticProgress: String, CaseIterable {

    case great = "GREAT"
    case good = "GOOD"
    case bad = "BAD"
    case empty = "empty"
    case future = "future"

    var barColor: UIColor {
        switch self {
        case .great:
            return UIColor.brainGreen
        case .good:
            return UIColor.yellowWarm
        case .bad:
            return UIColor.brainPink
        case .empty, .future:
            return UIColor.clear
        }
    }

    var timeColor: UIColor {
        switch self {
        case .great:
            return UIColor.darkGreen
        case .good:
            return UIColor.yellowWarmDark
        case .bad:
            return UIColor.darkPink
        case .empty, .future:
            return UIColor.clear
        }
    }

    var monthImage: UIImage? {
        switch self {
        case .great:
            return UIImage(named: "greatMonth")
        case .good:
            return UIImage(named: "goodMonth")
        case .bad:
            return UIImage(named: "badMonth")
        case .empty:
            return UIImage(named: "emptyMonth")
        case .future:
            return UIImage(named: "futureMonth")
        }
    }

    static func matchedCase(for string: String) -> StatisticProgress {
        allCases.filter { $0.rawValue == string }.first ?? .empty
    }
}
