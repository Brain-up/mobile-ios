//
//  UIColor.swift
//  BrainUp
//
//  Created by Evgenii Zhigunov on 2/16/22.
//

import UIKit

extension UIColor {
    class var almostBlack: UIColor {
        UIColor.getByName("almostBlack")
    }
    
    class var appWhite: UIColor {
        UIColor.getByName("appWhite")
    }
    
    class var brainGreen: UIColor {
        UIColor.getByName("brainGreen")
    }
    
    class var brainPink: UIColor {
        UIColor.getByName("brainPink")
    }
    
    class var charcoalGrey: UIColor {
        UIColor.getByName("charcoalGrey")
    }
    
    class var coldViolet: UIColor {
        UIColor.getByName("coldViolet")
    }
    
    class var darkGreen: UIColor {
        UIColor.getByName("darkGreen")
    }
    
    class var darkViolet: UIColor {
        UIColor.getByName("darkViolet")
    }
    
    class var hardlyGrey: UIColor {
        UIColor.getByName("hardlyGrey")
    }
    
    class var latterGrey: UIColor {
        UIColor.getByName("latterGrey")
    }
    
    class var latteViolet: UIColor {
        UIColor.getByName("latteViolet")
    }

    class var mouseGrey: UIColor {
        UIColor.getByName("mouseGrey")
    }
    
    class var warmViolet: UIColor {
        UIColor.getByName("warmViolet")
    }

    class var activeGray: UIColor {
        UIColor.getByName("activeGray")
    }

    class var shadowColor: UIColor {
        UIColor.getByName("shadowColor")
    }
    class var buttonBorder: UIColor {
        UIColor.getByName("buttonBorder")
    }
    
    static func == (left: UIColor, right: UIColor) -> Bool {
        var red1: CGFloat = 0
        var green1: CGFloat = 0
        var blue1: CGFloat = 0
        var alpha1: CGFloat = 0
        left.getRed(&red1, green: &green1, blue: &blue1, alpha: &alpha1)
        var red2: CGFloat = 0
        var green2: CGFloat = 0
        var blue2: CGFloat = 0
        var alpha2: CGFloat = 0
        right.getRed(&red2, green: &green2, blue: &blue2, alpha: &alpha2)
        return red1==red2 && green1==green2 && blue1 == blue2 && alpha1 == alpha2
    }
    
    static func getByName(_ name: String) -> UIColor {
        return UIColor(named: name) ?? UIColor.clear
    }
}
