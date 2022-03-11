//
//  SplachVC.swift
//  BrainUp
//
//  Created by Evgenii Zhigunov on 3/11/22.
//

import UIKit

class SplashVC: BasicVC {
    var model: SplashVMProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        model?.checkIsAuth()
    }
    
    private func setupUI() {
        view.backgroundColor = .appWhite
        let logoImg = UIImageView(image: UIImage(named: "LaunchScreenLogo"))
        view.addSubview(logoImg)
        logoImg.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImg.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImg.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
