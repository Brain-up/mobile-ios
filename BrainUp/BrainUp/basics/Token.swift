//
//  Token.swift
//  BrainUp
//
//  Created by Evgenii Zhigunov on 3/10/22.
//

import Foundation
import KeychainSwift

protocol TokenProtocol: AnyObject {
    // var shared: TokenProtocol {get}
    func isEmpty() -> Bool
    func reject()
    func save(_ token: String)
    func getToken() -> String?
}

class Token: TokenProtocol {
    static let shared: TokenProtocol = Token()
    
    private var tokenField = "Token"
    private var keychain = KeychainSwift()
    private init() {}
    
    func isEmpty() -> Bool {
        return keychain.get(tokenField)?.isEmpty ?? true
    }
    
    func reject() {
        keychain.delete(tokenField)
    }
    
    func save(_ token: String) {
        keychain.set(token, forKey: tokenField, withAccess: .accessibleAfterFirstUnlock)
    }
    
    func getToken() -> String? {
        return keychain.get(tokenField)
    }
}
