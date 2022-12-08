//
//  StatisticItemsMapper.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 25/02/2022.
//

import Foundation

class StatisticItemsMapper {
    func statisticItemsWithEmptyValuesForMissedItems<T>(inside range: DateRangeString, for dates: [T], increaseDateBy action: (Date) -> Date) -> [T] where T: EmptyDateItem {
        guard let startDate = StatisticDateHelper.dateDayFormatter.date(from: range.startDate),
              let endDate = StatisticDateHelper.dateDayFormatter.date(from: range.endDate),
              startDate < endDate else {
                  return dates
              }

        var result = [EmptyDateItem]()
        var hashMap = [Date: Int]()
        // create hashMap -> ["value": "index"]
        dates.enumerated().forEach {
            hashMap[$0.element.date] = $0.offset
        }

        var date = startDate

        while date <= endDate {
            // if our hashMap contains element for current data -> add to result array
            if let index = hashMap[date] {
                result.append(dates[index])
            } else {
                // else add to result array empty item
                result.append(T.emptyItem(for: date))
            }
            // increase date by 1 day
            date = action(date)
        }
        guard let result = result as? [T] else { return dates }
        return result
    }
}
