//
//  NetworkService.swift
//  BrainUp
//
//  Created by Evgenii Zhigunov on 2/18/22.
//

import Foundation

protocol NetworkService {
    func fetch<T: Decodable>(_ request: Request, completion: @escaping (Result<T, Error>) -> Void)
}
