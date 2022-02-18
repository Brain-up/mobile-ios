//
//  Strings.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 18/02/2022.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
