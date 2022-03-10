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
        authStateHandle = Auth.auth().addStateDidChangeListener { _, user in
            if user != nil {
                user?.getIDToken(completion: { token, error in
                    if error == nil {
                        Token.shared.save(token ?? "")
                    }
                })
            }
        }
    }
    
    func auth(login: String, password: String) {
        Auth.auth().signIn(withEmail: login, password: password) {[weak self] _, error in
            if error != nil {
                self?.view?.showError(errorMessage: error?.localizedDescription)
            }
        }
                           
    }
    
    func register(login: String, password: String) {
        Auth.auth().createUser(withEmail: login, password: password) {[weak self] _, error in
            if error != nil {
                self?.view?.showError(errorMessage: error?.localizedDescription)
            }
        }
    }
    
    deinit {
        Auth.auth().removeStateDidChangeListener(authStateHandle)
    }
}
