//
//  StatisticWeekItemsMapper.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 19/02/2022.
//

import Foundation

internal final class StatisticWeekItemsMapper {
     
    private struct Root: Decodable {
        let data: [Item]
        let errors: [String]
        let meta: [String]
        
        var weekStatistic: [DayItem] {
            return data.map { $0.item }
        }
    }

    private struct Item: Decodable {
        public let date: Date
        public let exercisingTimeSeconds: Int
        public let progress: String

        var item: DayItem {
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.minute, .second]
            formatter.unitsStyle = .positional

            let timeInMinutes = formatter.string(from: TimeInterval(exercisingTimeSeconds))!
            let easyToChangeProgress = Progress.matchedCase(for: progress)
            return DayItem(date: date, exercisingTimeMinutes: timeInMinutes, exercisingTimeSeconds: exercisingTimeSeconds, progress: easyToChangeProgress)
        }
    }
    
    private static var OK200: Int { return 200 }

    internal static func map(_ data: Data, from response: HTTPURLResponse) -> LoadWeeksResult {
        let decoder =  JSONDecoder()
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        guard response.statusCode == OK200, let root = try? decoder.decode(Root.self, from: data) else {
            return .failure(NSError(domain: "", code: 0, userInfo: nil))
        }
        
//        let first = formatter.date(from: "2022-01-20")!
//        let second = formatter.date(from: "2022-02-28")
//        let result = Mapper.weeksWithEmptyValuesForMissedDays(from: first, to: second!, inside: root.weekStatistic)
        return .success(root.weekStatistic)
    }
}

public enum LoadWeeksResult {
    case success([DayItem])
    case failure(Error)
}

public enum Progress: String, CaseIterable {
    case great = "GREAT"
    case good = "GOOD"
    case bad = "BAD"
    case unspecified = "unspecified"

    static func matchedCase(for string: String) -> Progress {
        allCases.filter { $0.rawValue == string }.first ?? .unspecified
    }
}

public struct DayItem: Equatable {
    public let date: Date
    public let exercisingTimeMinutes: String
    public let exercisingTimeSeconds: Int
    public let progress: Progress

    public init(date: Date, exercisingTimeMinutes: String, exercisingTimeSeconds: Int, progress: Progress) {
        self.date = date
        self.exercisingTimeMinutes = exercisingTimeMinutes
        self.exercisingTimeSeconds = exercisingTimeSeconds
        self.progress = progress
    }
}

class WeekDataMock {
    static func createData() -> Data {
        json.data(using: .utf8)!
    }
    static let json = """
    {"data":
[{"date":"2022-02-19","exercisingTimeSeconds":255,"progress":"BAD"},
{"date":"2022-02-09","exercisingTimeSeconds":61,"progress":"BAD"},
{"date":"2022-02-11","exercisingTimeSeconds":21,"progress":"BAD"},
{"date":"2022-01-31","exercisingTimeSeconds":1091,"progress":"GOOD"},
{"date":"2022-02-08","exercisingTimeSeconds":349,"progress":"BAD"},
{"date":"2022-02-03","exercisingTimeSeconds":67,"progress":"BAD"},
{"date":"2022-02-07","exercisingTimeSeconds":113,"progress":"BAD"}],
"errors":[],
"meta":[]}
"""
}
