//
//  AppTabbarController.swift
//  BrainUp
//
//  Created by Evgenii Zhigunov on 2/17/22.
//

import UIKit

class AppTabbarController: UITabBarController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        tabBar.isTranslucent = false
        tabBar.tintColor = .coldViolet
        tabBar.unselectedItemTintColor = .charcoalGrey
        tabBar.backgroundColor = .appWhite
        tabBar.layer.insertSublayer(getTabbarBackground(), at: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    private func getTabbarBackground() -> CAGradientLayer {
        let gradientlayer = CAGradientLayer().getGradientLayer(
            firstColor: UIColor.warmViolet.withAlphaComponent(0.15).cgColor,
            secondColor: UIColor.coldViolet.withAlphaComponent(0.15).cgColor)
        let frame = tabBar.bounds
        let maxHeight = frame.height + (UIApplication.shared.windows.first?.safeAreaInsets.bottom  ?? 0)
        gradientlayer.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: maxHeight)
        return gradientlayer
    }
}
