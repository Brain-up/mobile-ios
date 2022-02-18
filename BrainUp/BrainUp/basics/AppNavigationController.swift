//
//  AppNavigationController.swift
//  BrainUp
//
//  Created by Evgenii Zhigunov on 2/17/22.
//

import UIKit

class AppNavigationController: UINavigationController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [
                .foregroundColor: UIColor.white,
                .font: UIFont.montserratBold(size: 18)
            ]
            navBarAppearance.backgroundColor = .darkViolet
            navBarAppearance.shadowColor = .clear
            navigationBar.standardAppearance = navBarAppearance
            navigationBar.scrollEdgeAppearance = navBarAppearance
            navigationBar.prefersLargeTitles = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
