//
//  StatisticRequest.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 24/02/2022.
//

import Foundation

typealias DateRange = (startDate: String, endDate: String)

enum StatisticRequest: Request {
    case week(DateRange)
    case year(DateRange)

    private var mainPath: String {
        "/v2/statistics/study/"
    }

    private var fromKey: String {
        "from"
    }

    private var toKey: String {
        "to"
    }

    private func queryItems(for range: DateRange) -> String {
        "?" + fromKey + "=" + range.startDate + toKey + "=" + range.endDate
    }
}

extension StatisticRequest {
    var path: String {
        switch self {
        case let .week(range):
            return mainPath + "week" + queryItems(for: range)
        case let .year(range):
            return mainPath + "year" + queryItems(for: range)
        }
    }
}

extension StatisticRequest {
    var method: HTTPMethod {
        return HTTPMethod.get
    }
}

extension StatisticRequest {
    var encoding: Encoding {
        return .JSONEncoding
    }
}

extension StatisticRequest {
    var queryItems: [String: Any]? {
        return nil
//        switch self {
//        case let .week(range):
//            return [fromKey: range.startDate, toKey: range.endDate]
//        case let .year(range):
//            return [fromKey: range.startDate, toKey: range.endDate]
//        }
    }
}
