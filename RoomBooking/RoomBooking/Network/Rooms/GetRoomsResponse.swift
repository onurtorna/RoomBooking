//
//  GetRoomsResponse.swift
//  RoomBooking
//
//  Created by Onur Torna on 20/04/18.
//

import Foundation

struct GetRoomsResponse: Response, Codable {

    var roomList: [Room]?

    init?(with jsonArray: [[String: Any]]?) {
        guard let jsonArray = jsonArray else { return nil }

        roomList = []

        for json in jsonArray {
            if let room = Room.init(with: json) {
                roomList?.append(room)
            }
        }
    }
}
