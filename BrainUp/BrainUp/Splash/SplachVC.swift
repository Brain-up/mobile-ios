//
//  SplachVC.swift
//  BrainUp
//
//  Created by Evgenii Zhigunov on 3/11/22.
//

import UIKit

class SplashVC: UIViewController {
    var model: SplashVMProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model?.checkIsAuth()
    }
}
