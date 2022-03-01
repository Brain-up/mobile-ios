//
//  NetworkServiceMock.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 25/02/2022.
//

import Foundation

class NetworkServiceMock: NetworkService {
    enum RequestType {
        case week
        case year
    }

    private let type: RequestType

    init(type: RequestType) {
        self.type = type
    }
    func fetch<T>(_ request: Request, model: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T: Decodable {
        let data: Data
        switch type {
        case .week:
            data = WeekDataMock.createData()
        case .year:
            data = YearDataMock.createData()
        }
        let result = try? JSONDecoder().decode(T.self, from: data)
        completion(Result.success(result!))
    }
}
class WeekDataMock {
    static func createData() -> Data {
        json.data(using: .utf8)!
    }
    static let json = """
    {"data":
[{"date":"2022-02-19","exercisingTimeSeconds":255,"progress":"BAD"},
{"date":"2022-02-3","exercisingTimeSeconds":61,"progress":"BAD"},
{"date":"2022-02-1","exercisingTimeSeconds":21,"progress":"BAD"},
{"date":"2022-02-22","exercisingTimeSeconds":1091,"progress":"GOOD"},
{"date":"2022-02-01","exercisingTimeSeconds":349,"progress":"BAD"},
{"date":"2022-02-13","exercisingTimeSeconds":67,"progress":"BAD"},
{"date":"2022-02-12","exercisingTimeSeconds":113,"progress":"BAD"},
{"date":"2022-02-04","exercisingTimeSeconds":113,"progress":"BAD"},
{"date":"2022-02-05","exercisingTimeSeconds":113,"progress":"BAD"},
{"date":"2022-02-11","exercisingTimeSeconds":113,"progress":"BAD"},
{"date":"2022-02-20","exercisingTimeSeconds":113,"progress":"BAD"},
{"date":"2022-02-25","exercisingTimeSeconds":2222,"progress":"GREAT"}],
"errors":[],
"meta":[]}
"""
}
class YearDataMock {
    static func createData() -> Data {
        json.data(using: .utf8)!
    }
    static let json = """
"""
}
