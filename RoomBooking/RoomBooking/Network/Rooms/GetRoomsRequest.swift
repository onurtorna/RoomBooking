//
//  GetRoomsRequest.swift
//  RoomBooking
//
//  Created by Onur Torna on 19/04/18.
//

import Foundation

final class GetRoomsRequest: Request {

    private enum Constants {
        static let dateKey = "date"
        static let pathValue = "getrooms"
        static let nowDateValue = "now"
        static let todayDateValue = "today"
    }

    var path = Constants.pathValue

    /// String value of a date
    var stringDate: String?

    /// Selected date value of the request
    var date: Date?

    var parameters: [String : Any]? {

        if let stringDate = stringDate,
            (stringDate == Constants.nowDateValue
            || stringDate == Constants.todayDateValue) {
            return [Constants.dateKey: stringDate]
        } else if let date = date {
            let timeStamp = date.timeIntervalSinceNow
            return [Constants.dateKey: timeStamp]
        }

        return nil
    }

    init(stringDate: String?, date: Date?) {
        if let date = date {
            self.date = date
        } else if let stringDate = stringDate {
            self.stringDate = stringDate
        }
    }

}
