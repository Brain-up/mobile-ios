//
//  TabBarItemViewModel.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 18/02/2022.
//

import UIKit

protocol TabBarItemViewModelProtocol {
    var title: String { get }
    var topTabViews: [TopTabView] { get }
    var rightBarButtons: [UIImage?] { get }
    var rightBarbuttonAction: ((_ tag: Int) -> Void)? { get set }
}

struct TabBarItemViewModel: TabBarItemViewModelProtocol {
    let title: String
    let topTabViews: [TopTabView]
    let rightBarButtons: [UIImage?]
    var rightBarbuttonAction: ((_ tag: Int) -> Void)?
}
