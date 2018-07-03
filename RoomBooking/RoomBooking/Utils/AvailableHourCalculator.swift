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


    /// Calculates rooms' available hour intervals with given available hours list
    /// For example with a list ["07:00 - 16:00", "18:00 - 19:00"]
    /// Result would be [7: [true,true,true,true] , 8:[true,true,true,true], ..., 18:[true,true,true,true]]
    ///
    /// - Parameter availableHourList: Available hours string list with [HH:mm - HH:mm] format
    /// - Returns: Available hour intervals with 15 minutes
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

    /// Calculates available hour intervals for a given string
    ///
    /// - Parameter hourInterval: Available hour string with "HH:mm - HH:mm" format
    /// - Returns: Available hour intervals with 15 minutes
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

    /// Calculates available minute intervals within an hour
    /// For example with begin minute of 0 and end minute of 30
    /// Would result [true, true, false, false] indicating that first half of the hour is available
    ///
    /// - Parameters:
    ///   - beginMinute: Hour availability start minute eg. 0, 15, 30, 45
    ///   - endMinute: Hour availability end minute eg. 0, 15, 30, 45
    /// - Returns: Availability intervals of the hour
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
