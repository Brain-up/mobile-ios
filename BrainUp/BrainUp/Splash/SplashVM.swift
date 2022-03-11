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
    weak var view: BasicViewInterface?
    
    init(view: BasicViewInterface, delegate: SplashDelegate) {
        self.view = view
        self.delegate = delegate
    }
    
    func checkIsAuth() {
        view?.showLoading()
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            self.view?.hideLoading()
            self.delegate?.onUserAuthorized()
        }
        
    }
}
