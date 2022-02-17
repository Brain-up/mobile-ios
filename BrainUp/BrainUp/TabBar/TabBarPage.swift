//
//  TabBarPage.swift
//  BrainUp
//
//  Created by Evgenii Zhigunov on 2/16/22.
//

import Foundation
import UIKit

enum TabBarPage: Int, CaseIterable {
    case exercises = 0
    case statistics = 1
    case diagnostics = 2
    case profile = 3
    
    init?(index: Int) {
        self.init(rawValue: index)
    }
    
    func pageOrderNumber() -> Int {
        return self.rawValue
    }
    
    func pageTitleValue() -> String {
        return "\(self.rawValue)"
    }
    
    func getTabIcon() -> UIImage? {
        switch self {
        case .exercises:
            return UIImage(named: "exersicesIcon")?.withRenderingMode(.alwaysTemplate)
        case .statistics:
            return UIImage(named: "statisticsIcon")?.withRenderingMode(.alwaysTemplate)
        case .diagnostics:
            return UIImage(named: "diagnosticsIcon")?.withRenderingMode(.alwaysTemplate)
        case .profile:
            return UIImage(named: "profileIcon")?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    func getCoordinator() -> Coordinator.Type {
        switch self {
        case .exercises:
            return ExersicesCoordinator.self
        case .statistics:
            return StatisticsCoordinator.self
        case .diagnostics:
            return DiagnosticsCoordinator.self
        case .profile:
            return DiagnosticsCoordinator.self
        }
    }
}
