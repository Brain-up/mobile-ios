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
        UIFont(name: "Montserrat-Bold", size: size) ?? UIFont.systemFont(ofSize: size)
    }

    class func montserratSemiBold(size: CGFloat) -> UIFont {
        UIFont(name: "Montserrat-SemiBold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    class func openSansRegular(size: CGFloat) -> UIFont {
        UIFont(name: "OpenSans-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    class func reenieBeanie(size: CGFloat) -> UIFont {
        UIFont(name: "ReenieBeanie", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
