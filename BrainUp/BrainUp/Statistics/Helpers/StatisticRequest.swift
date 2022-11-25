//
//  StatisticRequest.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 24/02/2022.
//

import Foundation

typealias DateRangeString = (startDate: String, endDate: String)

struct DateRange: Equatable {
    var startDate: Date
    var endDate: Date

    mutating func update(_ dateRange: DateRange) {
        if dateRange.startDate < startDate {
            startDate = dateRange.startDate
        }
        if dateRange.endDate > endDate {
           endDate = dateRange.endDate
        }
    }
}

enum StatisticRequest: Request {
    case week(DateRangeString)
    case year(DateRangeString)

    private var mainPath: String {
        "/v2/statistics/study/"
//        "/statistics/study/"
    }
    private var fromKey: String {
        "from"
    }
    private var toKey: String {
        "to"
    }

    private func queryItems(for range: DateRangeString) -> String {
        "?" + fromKey + "=" + range.startDate + "&" + toKey + "=" + range.endDate
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
    }
}
