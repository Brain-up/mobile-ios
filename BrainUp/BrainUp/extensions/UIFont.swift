//
//  UIFont.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 17/02/2022.
//

import UIKit

extension UIFont {
    class func montserratRegular(size: CGFloat) -> UIFont {
        UIFont(name: "Montserrat-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }

    class func montserratBold(size: CGFloat) -> UIFont {
        UIFont(name: "Montserrat-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }

    class func montserratSemiBold(size: CGFloat) -> UIFont {
        UIFont(name: "Montserrat-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
}