//
//  SplashVM.swift
//  BrainUp
//
//  Created by Evgenii Zhigunov on 3/11/22.
//

import Foundation
import FirebaseAuth

protocol SplashVMProtocol: AnyObject {
    func checkIsAuth()
}

class SplashVM: SplashVMProtocol {
    weak var delegate: SplashDelegate?
    weak var view: BasicViewInterface?
    private var handler: IDTokenDidChangeListenerHandle
    
    init(view: BasicViewInterface, delegate: SplashDelegate) {
        self.view = view
        self.delegate = delegate
        // TODO: Create AuthProvider protocol & inject it
        handler = Auth.auth().addIDTokenDidChangeListener { _, user in
            guard let authUser = user else {
                Token.shared.reject()
                return
            }
            authUser.getIDToken { token, error in
                if error == nil {
                    Token.shared.save(token ?? "")
                } else {
                    view.showError(errorMessage: error?.localizedDescription)
                }
            }
        }
    }
    
    func checkIsAuth() {
        view?.showLoading()
        if Token.shared.isEmpty() {
            view?.hideLoading()
            delegate?.onUserUnauthorized()
        } else {
            view?.hideLoading()
            delegate?.onUserAuthorized()
        }
        
    }
    
    deinit {
        Auth.auth().removeIDTokenDidChangeListener(handler)
    }
}
