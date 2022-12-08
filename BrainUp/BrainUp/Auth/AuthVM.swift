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
    private weak var delegate: AuthDelegate?
    
    init(view: BasicViewInterface, delegate: AuthDelegate) {
        self.view = view
        self.delegate = delegate
        // TODO: Create AuthProvider protocol & inject it
        authStateHandle = Auth.auth().addStateDidChangeListener { _, user in
            guard let authUser = user else { return }
            authUser.getIDToken(completion: { token, error in
                if error == nil {
                    Token.shared.save(token ?? "")
                    delegate.onSuccessAuthrized()
                } else {
                    view.showError(errorMessage: error?.localizedDescription)
                }
            })
        }
    }
    
    func auth(login: String, password: String) {
        view?.showLoading()
        Auth.auth().signIn(withEmail: login, password: password) {[weak self] data, error in
            self?.view?.hideLoading()
            print(data)
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
