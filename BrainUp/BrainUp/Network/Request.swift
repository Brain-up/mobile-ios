//
//  TargetType.swift
//  BrainUp
//
//  Created by Evgenii Zhigunov on 2/18/22.
//

import Foundation

protocol Request {
    var baseURL: String {get}
    var path: String {get}
    var method: HTTPMethod {get}
    var headers: [String: String] {get}
    var queryItems: [String: Any]? { get }
    // parameters which are included inside of the request body
    var parameters: [String: Any]? { get }
    var encoding: Encoding {get}
}

extension Request {
    var baseURL: String {
        "https://brainup.site/api"
    }
}

extension Request {
    var headers: [String: String] {
        [:]
    }
    
    var parameters: [String: Any]? {
        nil
    }
}
