//
//  StatisticWeekItemsMapper.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 19/02/2022.
//

import UIKit

typealias WeekResult = Result<[StatisticWeekItem], Error>

protocol StatisticWeekItemsMapperProtocol {
    func fetch(for range: DateRangeString, with networkServise: NetworkService, completion: @escaping (WeekResult) -> Void)
    func fetchFutureItems(for range: DateRangeString, completion: @escaping (WeekResult) -> Void) 
}

final class StatisticWeekItemsMapper: StatisticItemsMapper, StatisticWeekItemsMapperProtocol {
     
    private struct Root: Decodable {
        let data: [Item]
        let errors: [String]
        let meta: [String]
        
        var weekStatistic: [StatisticDayItem] {
            return data.map { $0.item }
        }
    }

    private struct Item: Decodable {
        let date: String
        let exercisingTimeSeconds: Int
        let progress: String

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

    func fetch(for range: DateRangeString, with networkServise: NetworkService, completion: @escaping (WeekResult) -> Void) {
        networkServise.fetch(StatisticRequest.week(range), model: Root.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(root):
                let resultWithEmptyDays = self.statisticItemsWithEmptyValuesForMissedItems(inside: range, for: root.weekStatistic) { date in
                    date.addDays(count: 1)
                }
                let chankedResult = resultWithEmptyDays.chunked(into: 7) // separate dates in weeks
                let weekResult = chankedResult.map { StatisticWeekItem(days: $0) }
                completion(.success(weekResult))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func fetchFutureItems(for range: DateRangeString, completion: @escaping (WeekResult) -> Void) {
        let emptyArray = [StatisticDayItem]()
        let resultWithEmptyDays = statisticItemsWithEmptyValuesForMissedItems(inside: range, for: emptyArray) { date in
            date.addDays(count: 1)
        }
        let chankedResult = resultWithEmptyDays.chunked(into: 7) // separate dates in weeks
        let weekResult = chankedResult.map { StatisticWeekItem(days: $0) }
        completion(.success(weekResult))
    }
}
