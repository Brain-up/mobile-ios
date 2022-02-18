//
//  EmptyStatisticViewModel.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 18/02/2022.
//

import UIKit
protocol EmptyStatisticViewModelProtocol {
    var message: String { get }
    var buttonTitle: String { get }
    var image: UIImage? { get }

    var startExercisesButtonAction: (() -> Void)? { get set }
}

struct EmptyStatisticViewModel: EmptyStatisticViewModelProtocol {
    var message: String = "Чтобы получить статистику, \nнужно начать выполнять упражнения"
    var buttonTitle: String = "начать занятия".uppercased()
    var image: UIImage? = UIImage(named: "noStatisticResults")

    var startExercisesButtonAction: (() -> Void)?
}
