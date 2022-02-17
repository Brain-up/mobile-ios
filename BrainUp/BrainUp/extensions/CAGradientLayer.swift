//
//  CAGradientLayer.swift
//  BrainUp
//
//  Created by Evgenii Zhigunov on 2/17/22.
//

import Foundation
import QuartzCore

extension CAGradientLayer {
    func getGradientLayer(firstColor: CGColor, secondColor: CGColor) -> CAGradientLayer {
        self.colors = [firstColor, secondColor]
        self.locations = [0, 1]
        self.startPoint = CGPoint(x: 0.25, y: 0.5)
        self.endPoint = CGPoint(x: 0.75, y: 0.5)
        self.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1, b: 0, c: 0, d: 1.73, tx: 0, ty: -0.37))
        return self
    }
}
