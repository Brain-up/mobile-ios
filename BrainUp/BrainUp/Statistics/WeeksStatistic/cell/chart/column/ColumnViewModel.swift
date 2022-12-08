//
//  ColumnViewModel.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 26/02/2022.
//

import UIKit

protocol ColumnViewModelProtocol {
    var columnHeight: Double { get }
    var columnColor: UIColor { get }
    var timeColor: UIColor { get }

    var time: String { get }
}

struct ColumnViewModel: ColumnViewModelProtocol {
    let columnHeight: Double
    let columnColor: UIColor
    let timeColor: UIColor
    let time: String
}
