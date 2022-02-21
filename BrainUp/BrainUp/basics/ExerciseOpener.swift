//
//  ExerciseOpener.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 18/02/2022.
//

import Foundation

protocol ExerciseOpener {
    var openExercise: (() -> Void)? { get set }
}
