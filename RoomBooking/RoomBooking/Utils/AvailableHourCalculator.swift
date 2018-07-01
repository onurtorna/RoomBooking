//
//  AvailableHourCalculator.swift
//  RoomBooking
//
//  Created by Onur Torna on 01/07/18.
//

import Foundation

class AvailableHourCalculator {

    private enum Constant {
        static let hourIntervalSeperator: Character = "-"
        static let minuteIntervalSeperator: Character = ":"
        static let hourInterval = 15
        static let minimumMinute = 0
        static let maximumMinute = 60
    }

    static func calculateRoomAvailableHours(_ availableHourList: [String]?) -> [Int: [Bool]]? {
        guard let availableHourList = availableHourList else { return nil }

        var availableHours: [Int: [Bool]] = [:]

        for list in availableHourList {
            if let currentAvailableHours = calculateHourInterval(list) {
                availableHours = availableHours.merging(currentAvailableHours) { first, second in
                    return second
                }
            }
        }
        return availableHours
    }

    static func calculateHourInterval(_ hourInterval: String) -> [Int: [Bool]]? {
         let hours = hourInterval.split(separator: Constant.hourIntervalSeperator).compactMap { $0.replacingOccurrences(of: " ", with: "") }

        let begin = hours.first?.split(separator: Constant.minuteIntervalSeperator)
            .compactMap { Int($0) }

        let end = hours.last?.split(separator: Constant.minuteIntervalSeperator)
            .compactMap { Int($0) }

        guard let beginHour = begin?.first, let endHour = end?.first,
            let beginMinute = begin?.last, let endMinute = end?.last,
            beginHour <= endHour,
            beginMinute < Constant.maximumMinute,
            endMinute < Constant.maximumMinute else {
                return nil
        }

        var availableHours: [Int: [Bool]] = [:]
        for hour in beginHour...endHour {

            let currentHour: [Bool]
            let currentBeginMinute: Int
            let currentEndMinute: Int

            if endHour == beginHour {
                currentBeginMinute = beginMinute
                currentEndMinute = endMinute
            } else if hour == beginHour {
                currentBeginMinute = beginMinute
                currentEndMinute = Constant.maximumMinute
            } else if hour == endHour {
                currentBeginMinute = Constant.minimumMinute
                currentEndMinute = endMinute
            } else {
                currentBeginMinute = Constant.minimumMinute
                currentEndMinute = Constant.maximumMinute
            }

            currentHour = calculateWithinHour(beginMinute: currentBeginMinute,
                                              endMinute: currentEndMinute)
            availableHours[hour] = currentHour
        }

        return availableHours
    }

    static func calculateWithinHour(beginMinute: Int,
                                    endMinute: Int) -> [Bool] {

        var availableMinutes = [false, false, false, false]
        guard beginMinute >= Constant.minimumMinute,
            beginMinute <= Constant.maximumMinute,
            endMinute >= Constant.minimumMinute,
            endMinute <= Constant.maximumMinute,
            beginMinute < endMinute else {

                return availableMinutes
        }

        for index in (beginMinute / Constant.hourInterval)..<(endMinute / Constant.hourInterval) {
            availableMinutes[index] = true
        }

        return availableMinutes
    }

}
