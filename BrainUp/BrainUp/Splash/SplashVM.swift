//
//  SplashVM.swift
//  BrainUp
//
//  Created by Evgenii Zhigunov on 3/11/22.
//

import Foundation

protocol SplashVMProtocol: AnyObject {
    func checkIsAuth()
}

class SplashVM: SplashVMProtocol {
    weak var delegate: SplashDelegate?
    
    init(delegate: SplashDelegate) {
        self.delegate = delegate
    }
    
    func checkIsAuth() {
        delegate?.onUserAuthorized()
    }
}
