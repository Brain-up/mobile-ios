//
//  AuthVM.swift
//  BrainUp
//
//  Created by Evgenii Zhigunov on 3/9/22.
//

import Foundation

protocol AuthVMProtocol: AnyObject {
    func auth(login: String, password: String)
    func register(login: String, password: String)
}

class AuthVM: AuthVMProtocol {
    private weak var view: BasicViewInterface?
    
    init(view: BasicViewInterface) {
        self.view = view
    }
    
    func auth(login: String, password: String) {
        
    }
    
    func register(login: String, password: String) {
        
    }
}
