//
//  RequestMock.swift
//  BrainUpTests
//
//  Created by Evgenii Zhigunov on 3/18/22.
//

import Foundation
@testable import BrainUp

class RequestMock: Request {
    var queryItems: [String: Any]?
    
    var baseURL: String = ""
    
    var path: String = ""
    
    var method: HTTPMethod = .get
    
    var encoding: Encoding = .URLEncoding
}
