//
//  TokenMock.swift
//  BrainUpTests
//
//  Created by Evgenii Zhigunov on 3/14/22.
//

import Foundation
@testable import BrainUp

class TokenMock: TokenProtocol {
    private var token: String = ""
    
    func isEmpty() -> Bool {
        token.isEmpty
    }
    
    func reject() {
        token = ""
    }
    
    func save(_ token: String) {
        self.token = token
    }
    
    func getToken() -> String? {
        token
    }
}
