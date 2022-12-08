//
//  StatisticYearItemsMapper.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 19/02/2022.
//

import Foundation

typealias YearResult = Result<[StatisticMonthItem], Error>

protocol StatisticYearItemsMapperProtocol {
    func fetch(for range: DateRangeString, with networkServise: NetworkService, completion: @escaping (YearResult) -> Void)
}

final class StatisticYearItemsMapper: StatisticItemsMapper, StatisticYearItemsMapperProtocol {
     
    private struct Root: Decodable {
        let data: [Item]
        let errors: [String]
        let meta: [String]
        
        var yearStatistic: [StatisticMonthItem] {
            return data.map { $0.item }
        }
    }

    private struct Item: Decodable {
        public let date: String
        public let exercisingTimeSeconds: Int
        public let exercisingDays: Int
        public let progress: String

        var item: StatisticMonthItem {
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.hour, .minute, .second]
            formatter.unitsStyle = .positional
            formatter.zeroFormattingBehavior = .pad

            let date = StatisticDateHelper.dateMonthFormatter.date(from: date) ?? Date()
            
            let timeInHours = formatter.string(from: TimeInterval(exercisingTimeSeconds)) ?? ""
            let easyToChangeProgress = StatisticProgress.matchedCase(for: progress)
            return StatisticMonthItem(date: date, exercisingTimeHours: timeInHours, exercisingDays: exercisingDays, progress: easyToChangeProgress)
        }
    }

    func fetch(for range: DateRangeString, with networkServise: NetworkService, completion: @escaping (YearResult) -> Void) {
        networkServise.fetch(StatisticRequest.year(range), model: Root.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(root):
                let resultWitEmptyMonth = self.statisticItemsWithEmptyValuesForMissedItems(inside: range, for: root.yearStatistic) { date in
                    date.addMonths(count: 1)
                }
                completion(.success(resultWitEmptyMonth))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func fetchFutureItems(for range: DateRangeString, completion: @escaping (YearResult) -> Void) {
        let emptyArray = [StatisticMonthItem]()
        let resultWitEmptyMonth = statisticItemsWithEmptyValuesForMissedItems(inside: range, for: emptyArray) { date in
            date.addMonths(count: 1)
        }
        completion(.success(resultWitEmptyMonth))
    }
}
