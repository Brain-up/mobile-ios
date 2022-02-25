//
//  StatisticProgress.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 24/02/2022.
//

import UIKit

enum StatisticProgress: RawRepresentable, CaseIterable {
    init?(rawValue: (progressName: String, color: UIColor)) {
        return nil
    }

    case great
    case good
    case bad
    case unspecified

    var rawValue: (progressName: String, color: UIColor) {
        switch self {
        case .great:
            return (progressName: "GREAT", color: UIColor.brainGreen)
        case .good:
            return (progressName: "GOOD", color: UIColor.yellowWarm)
        case .bad:
            return (progressName: "BAD", color: UIColor.brainPink)
        case .unspecified:
            return (progressName: "unspecified", color: UIColor.clear)
        }
    }

    static func matchedCase(for string: String) -> StatisticProgress {
        allCases.filter { $0.rawValue.progressName == string }.first ?? .unspecified
    }
}
