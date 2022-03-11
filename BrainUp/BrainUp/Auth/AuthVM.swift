//
//  AuthVM.swift
//  BrainUp
//
//  Created by Evgenii Zhigunov on 3/9/22.
//

import Foundation
import FirebaseCore
import FirebaseAuth

protocol AuthVMProtocol: AnyObject {
    func auth(login: String, password: String)
    func register(login: String, password: String)
}

class AuthVM: AuthVMProtocol {
    private weak var view: BasicViewInterface?
    private var authStateHandle: AuthStateDidChangeListenerHandle!
    
    init(view: BasicViewInterface) {
        self.view = view
        // TODO: Create AuthProvider protocol & inject it
        authStateHandle = Auth.auth().addStateDidChangeListener { _, user in
            guard let authUser = user else { return }
            authUser.getIDToken(completion: { token, error in
                if error == nil {
                    Token.shared.save(token ?? "")
                } else {
                    view.showError(errorMessage: error?.localizedDescription)
                }
            })
        }
    }
    
    func auth(login: String, password: String) {
        view?.showLoading()
        Auth.auth().signIn(withEmail: login, password: password) {[weak self] _, error in
            self?.view?.hideLoading()
            if error != nil {
                self?.view?.showError(errorMessage: error?.localizedDescription)
            }
        }
                           
    }
    
    func register(login: String, password: String) {
        view?.showLoading()
        Auth.auth().createUser(withEmail: login, password: password) {[weak self] _, error in
            self?.view?.hideLoading()
            if error != nil {
                self?.view?.showError(errorMessage: error?.localizedDescription)
            }
        }
    }
    
    deinit {
        Auth.auth().removeStateDidChangeListener(authStateHandle)
    }
}
