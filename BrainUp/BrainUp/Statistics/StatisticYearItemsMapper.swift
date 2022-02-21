//
//  StatisticYearItemsMapper.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 19/02/2022.
//

import Foundation
internal final class StatisticYearItemsMapper {
     
    private struct Root: Decodable {
        let data: [Item]
        let errors: [String]
        let meta: [String]
        
        var yearStatistic: [MonthItem] {
            return data.map { $0.item }
        }
    }

    private struct Item: Decodable {
        public let date: Date
        public let exercisingTimeSeconds: Int
        public let exercisingDays: Int
        public let progress: String

        var item: MonthItem {
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.hour, .minute, .second]
            formatter.unitsStyle = .positional

            let timeInHours = formatter.string(from: TimeInterval(exercisingTimeSeconds))!
            let easyToChangeProgress = Progress.matchedCase(for: progress)
            return MonthItem(date: date, exercisingTimeHours: timeInHours, exercisingDays: exercisingDays, progress: easyToChangeProgress)
        }
    }
    
    private static var OK200: Int { return 200 }

    internal static func map(_ data: Data, from response: HTTPURLResponse) -> LoadYearsResult {
        let decoder =  JSONDecoder()
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM"
        decoder.dateDecodingStrategy = .formatted(formatter)
        guard response.statusCode == OK200, let root = try? decoder.decode(Root.self, from: data) else {
            return .failure(NSError(domain: "", code: 0, userInfo: nil))
        }

        return .success(root.yearStatistic)
    }
}
class Mapper {
    static func weeksWithEmptyValuesForMissedDays(from startDate: Date, to endDate: Date, inside weeks: [DayItem]) -> [DayItem] {
        guard startDate < endDate else {
            preconditionFailure("Start date should be before end date.")
        }
        var result = [DayItem]()
        var hashMap = [Date: Int]()
        weeks.enumerated().forEach {
            hashMap[$0.element.date] = $0.offset
        }

        var dayComponent = DateComponents()
        dayComponent.day = 1
        let theCalendar = Calendar.current

        var date = startDate

        while date <= endDate {
            if let index = hashMap[date] {
                result.append(weeks[index])
            } else {
                result.append(DayItem(date: date, exercisingTimeMinutes: "00:00", exercisingTimeSeconds: 0, progress: .unspecified))
            }
            date = theCalendar.date(byAdding: dayComponent, to: date)!
        }
        return result
    }
}

public enum LoadYearsResult {
    case success([MonthItem])
    case failure(Error)
}

public struct MonthItem: Equatable {
    public let date: Date
    public let exercisingTimeHours: String
    public let exercisingDays: Int
    public let progress: Progress

    public init(date: Date, exercisingTimeHours: String, exercisingDays: Int, progress: Progress) {
        self.date = date
        self.exercisingTimeHours = exercisingTimeHours
        self.exercisingDays = exercisingDays
        self.progress = progress
    }
}

class YearDataMock {
    static func createData() -> Data {
        json.data(using: .utf8)!
    }
    static let json = """
"""
}
