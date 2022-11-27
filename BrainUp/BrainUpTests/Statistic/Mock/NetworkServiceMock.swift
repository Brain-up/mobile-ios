//
//  NetworkServiceMock.swift
//  BrainUpTests
//
//  Created by Andrei Trukhan on 25/11/2022.
//

import Foundation
@testable import BrainUp

class NetworkServiceMock: NetworkService {
    enum RequestType {
        case week
        case year
    }
    static var count = 0

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
//        let result = try? JSONDecoder().decode(T.self, from: data)
        var result: T?
        do {
            result = try JSONDecoder().decode(T.self, from: data)
        } catch {
            print(error)
        }
//        let result = try? JSONDecoder().decode(T.self, from: data)
        completion(Result.success(result!))
    }
}
class WeekDataMock {
    static func createData() -> Data {
        json.data(using: .utf8)!
    }
    static let json = """
    {"data":
    [
        {"date":"2021-01-01","exercisingTimeSeconds":1000,"progress":"GREAT"},
        {"date":"2021-01-02","exercisingTimeSeconds":1440,"progress":"GREAT"},
        {"date":"2021-01-03","exercisingTimeSeconds":1330,"progress":"GREAT"},
        {"date":"2021-01-04","exercisingTimeSeconds":1323,"progress":"GREAT"},
        {"date":"2021-01-05","exercisingTimeSeconds":1545,"progress":"GREAT"},
        {"date":"2021-01-06","exercisingTimeSeconds":6111,"progress":"GREAT"},
        {"date":"2021-01-07","exercisingTimeSeconds":2333,"progress":"GREAT"},
        {"date":"2021-01-08","exercisingTimeSeconds":4333,"progress":"GREAT"},
        {"date":"2021-01-09","exercisingTimeSeconds":2878,"progress":"GREAT"},
        {"date":"2021-01-10","exercisingTimeSeconds":3883,"progress":"GREAT"},
        {"date":"2021-01-11","exercisingTimeSeconds":1233,"progress":"GREAT"},
        {"date":"2021-01-19","exercisingTimeSeconds":1201,"progress":"GREAT"},
        {"date":"2021-01-20","exercisingTimeSeconds":5005,"progress":"GREAT"},
        {"date":"2021-01-21","exercisingTimeSeconds":4004,"progress":"GREAT"},
        {"date":"2021-01-22","exercisingTimeSeconds":3003,"progress":"GREAT"},
        {"date":"2021-01-23","exercisingTimeSeconds":6040,"progress":"GREAT"},
        {"date":"2021-01-24","exercisingTimeSeconds":6200,"progress":"GREAT"},
        {"date":"2021-01-25","exercisingTimeSeconds":100,"progress":"BAD"},
        {"date":"2021-01-26","exercisingTimeSeconds":6070,"progress":"GREAT"},
        {"date":"2021-01-27","exercisingTimeSeconds":2000,"progress":"GREAT"},
        {"date":"2021-01-28","exercisingTimeSeconds":4500,"progress":"GREAT"},
        {"date":"2021-01-29","exercisingTimeSeconds":2020,"progress":"GREAT"},
        {"date":"2021-01-30","exercisingTimeSeconds":1020,"progress":"GOOD"},

        {"date":"2021-02-01","exercisingTimeSeconds":100,"progress":"BAD"},
        {"date":"2021-02-02","exercisingTimeSeconds":100,"progress":"BAD"},
        {"date":"2021-02-03","exercisingTimeSeconds":100,"progress":"BAD"},
        {"date":"2021-02-04","exercisingTimeSeconds":100,"progress":"BAD"},
        {"date":"2021-02-05","exercisingTimeSeconds":100,"progress":"BAD"},
        {"date":"2021-02-06","exercisingTimeSeconds":100,"progress":"BAD"},
        {"date":"2021-02-07","exercisingTimeSeconds":1000,"progress":"BAD"},
        {"date":"2021-02-08","exercisingTimeSeconds":100,"progress":"BAD"},
        {"date":"2021-02-09","exercisingTimeSeconds":100,"progress":"BAD"},
        {"date":"2021-02-10","exercisingTimeSeconds":100,"progress":"BAD"},
        {"date":"2021-02-11","exercisingTimeSeconds":100,"progress":"BAD"},
        {"date":"2021-02-12","exercisingTimeSeconds":1000,"progress":"GOOD"},

        {"date":"2022-02-19","exercisingTimeSeconds":255,"progress":"BAD"},
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
        {"date":"2022-02-25","exercisingTimeSeconds":2222,"progress":"GREAT"},

        {"date":"2022-03-6","exercisingTimeSeconds":1321,"progress":"GREAT"},
        {"date":"2022-03-7","exercisingTimeSeconds":990,"progress":"GOOD"},
        {"date":"2022-03-8","exercisingTimeSeconds":1322,"progress":"GREAT"},
        {"date":"2022-03-9","exercisingTimeSeconds":990,"progress":"GOOD"},
        {"date":"2022-03-10","exercisingTimeSeconds":1339,"progress":"GREAT"},
        {"date":"2022-03-11","exercisingTimeSeconds":990,"progress":"GOOD"},
        {"date":"2022-03-12","exercisingTimeSeconds":2001,"progress":"GREAT"},
        {"date":"2022-03-13","exercisingTimeSeconds":990,"progress":"GOOD"},
        {"date":"2022-03-14","exercisingTimeSeconds":100,"progress":"BAD"},
        {"date":"2022-03-15","exercisingTimeSeconds":990,"progress":"GOOD"},
        {"date":"2022-03-16","exercisingTimeSeconds":1000,"progress":"GOOD"},
        {"date":"2022-03-17","exercisingTimeSeconds":1241,"progress":"GREAT"},
        {"date":"2022-03-18","exercisingTimeSeconds":1404,"progress":"GREAT"},
        {"date":"2022-03-19","exercisingTimeSeconds":1349,"progress":"GREAT"},
        {"date":"2022-03-20","exercisingTimeSeconds":1230,"progress":"GREAT"},
        {"date":"2022-03-21","exercisingTimeSeconds":1000,"progress":"GOOD"},
        {"date":"2022-03-22","exercisingTimeSeconds":1235,"progress":"GREAT"},
        {"date":"2022-03-23","exercisingTimeSeconds":113,"progress":"BAD"}
    ],
"errors":[],
"meta":[]}
"""
}
class YearDataMock {
    static func createData() -> Data {
        return json.data(using: .utf8)!
    }
    static let json = """
{"data":
    [
        {"date":"2021-01","exercisingTimeSeconds":54000,"exercisingDays":23,"progress":"GREAT"},
        {"date":"2021-02","exercisingTimeSeconds":2700,"exercisingDays":12,"progress":"BAD"},
        {"date":"2021-3","exercisingTimeSeconds":30000,"exercisingDays":15,"progress":"GOOD"},
        {"date":"2021-4","exercisingTimeSeconds":32000,"exercisingDays":13,"progress":"GOOD"},
        {"date":"2021-5","exercisingTimeSeconds":234,"exercisingDays":1,"progress":"BAD"},
        {"date":"2021-6","exercisingTimeSeconds":58000,"exercisingDays":30,"progress":"BAD"},
        {"date":"2021-7","exercisingTimeSeconds":50000,"exercisingDays":22,"progress":"GREAT"},
        {"date":"2021-12","exercisingTimeSeconds":30000,"exercisingDays":2,"progress":"GOOD"},
        {"date":"2022-01","exercisingTimeSeconds":54500,"exercisingDays":30,"progress":"GREAT"},
        {"date":"2022-02","exercisingTimeSeconds":930,"exercisingDays":2,"progress":"BAD"},
        {"date":"2022-03","exercisingTimeSeconds":14509,"exercisingDays":18,"progress":"BAD"}
    ],
"errors":[],
"meta":[]}
"""
    static let json1 = """
{"data":
    [
        {"date":"2021-1","exercisingTimeSeconds":2733,"exercisingDays":1,"progress":"BAD"},
        {"date":"2021-2","exercisingTimeSeconds":270,"exercisingDays":48,"progress":"GOOD"},
        {"date":"2021-3","exercisingTimeSeconds":1432,"exercisingDays":48,"progress":"GREAT"},
        {"date":"2021-4","exercisingTimeSeconds":2733,"exercisingDays":48,"progress":"GREAT"},
        {"date":"2021-5","exercisingTimeSeconds":234,"exercisingDays":1,"progress":"BAD"},
        {"date":"2021-6","exercisingTimeSeconds":2733,"exercisingDays":1,"progress":"BAD"},
        {"date":"2021-7","exercisingTimeSeconds":754,"exercisingDays":22,"progress":"GREAT"},
        {"date":"2021-12","exercisingTimeSeconds":2733,"exercisingDays":2,"progress":"BAD"},
        {"date":"2022-01","exercisingTimeSeconds":11,"exercisingDays":3,"progress":"BAD"},
        {"date":"2022-02","exercisingTimeSeconds":11,"exercisingDays":4,"progress":"BAD"}
    ],
"errors":[],
"meta":[]}
"""
    static let json2 = """
{"data":
    [
        {"date":"2021-1","exercisingTimeSeconds":2733,"exercisingDays":1,"progress":"BAD"},
        {"date":"2021-2","exercisingTimeSeconds":270,"exercisingDays":48,"progress":"GOOD"},
        {"date":"2021-3","exercisingTimeSeconds":1432,"exercisingDays":48,"progress":"GREAT"},
        {"date":"2021-4","exercisingTimeSeconds":2733,"exercisingDays":48,"progress":"GREAT"},
        {"date":"2021-5","exercisingTimeSeconds":234,"exercisingDays":1,"progress":"BAD"},
        {"date":"2021-6","exercisingTimeSeconds":2733,"exercisingDays":1,"progress":"BAD"},
        {"date":"2021-7","exercisingTimeSeconds":754,"exercisingDays":22,"progress":"GREAT"},
        {"date":"2021-12","exercisingTimeSeconds":2733,"exercisingDays":2,"progress":"BAD"},
        {"date":"2022-01","exercisingTimeSeconds":20,"exercisingDays":1,"progress":"GOOD"},
        {"date":"2022-02","exercisingTimeSeconds":1,"exercisingDays":1,"progress":"BAD"}
    ],
"errors":[],
"meta":[]}
"""
}
