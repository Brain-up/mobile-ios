//
//  StatisticWeekItemsMapper.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 19/02/2022.
//

import UIKit

typealias WeekResult = Result<[StatisticDayItem], Error>

final class StatisticWeekItemsMapper: StatisticItemsMapper {
     
    private struct Root: Decodable {
        let data: [Item]
        let errors: [String]
        let meta: [String]
        
        var weekStatistic: [StatisticDayItem] {
            return data.map { $0.item }
        }
    }

    private struct Item: Decodable {
        public let date: String
        public let exercisingTimeSeconds: Int
        public let progress: String

        var item: StatisticDayItem {
            let minutesFormatter = DateComponentsFormatter()
            minutesFormatter.allowedUnits = [.minute, .second]
            minutesFormatter.unitsStyle = .positional
            let timeInMinutes = minutesFormatter.string(from: TimeInterval(exercisingTimeSeconds))!

            let date = StatisticDateHelper.dateDayFormatter.date(from: date) ?? Date()

            let easyToChangeProgress = StatisticProgress.matchedCase(for: progress)
            return StatisticDayItem(date: date,
                           exercisingTimeMinutes: timeInMinutes,
                           exercisingTimeSeconds: exercisingTimeSeconds,
                           progress: easyToChangeProgress)
        }
    }

    func fetch(for range: DateRange, with networkServise: NetworkService, completion: @escaping (WeekResult) -> Void) {
        networkServise.fetch(StatisticRequest.week(range), model: Root.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(root):
                let resultWitEmptyDays = self.statisticItemsWithEmptyValuesForMissedItems(inside: range, for: root.weekStatistic) { date in
                    date.addDays(count: 1)
                }
                completion(.success(resultWitEmptyDays))
            case let .failure(error):
                completion(.failure(error))
            }
        }
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
