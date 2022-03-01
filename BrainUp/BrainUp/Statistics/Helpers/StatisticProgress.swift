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
    case unspecified = "unspecified"

    var barColor: UIColor {
        switch self {
        case .great:
            return UIColor.brainGreen
        case .good:
            return UIColor.yellowWarm
        case .bad:
            return UIColor.brainPink
        case .unspecified:
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
        case .unspecified:
            return UIColor.clear
        }
    }

    static func matchedCase(for string: String) -> StatisticProgress {
        allCases.filter { $0.rawValue == string }.first ?? .unspecified
    }
}
