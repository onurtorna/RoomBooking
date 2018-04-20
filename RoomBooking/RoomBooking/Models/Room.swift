//
//  Room.swift
//  RoomBooking
//
//  Created by Onur Torna on 20/04/18.
//

import Foundation

struct Room: Codable {

    var name: String?
    var location: String?
    var equipmentList: [String]?
    var size: String?
    var capacity: Int?
    var availableHours: [String]?
    var imageUrls: [String]?

    enum CodingKeys: String, CodingKey {
        case name
        case location
        case equipmentList = "equipment"
        case size
        case capacity
        case availableHours = "avail"
        case imageUrls = "images"
    }

    init?(with dictionary: [String: Any]?) {
        guard let dictionary = dictionary else { return nil }

        name = dictionary[CodingKeys.name.rawValue] as? String
        location = dictionary[CodingKeys.location.rawValue] as? String
        equipmentList = dictionary[CodingKeys.equipmentList.rawValue] as? [String]
        size = dictionary[CodingKeys.size.rawValue] as? String
        capacity = dictionary[CodingKeys.capacity.rawValue] as? Int
        availableHours = dictionary[CodingKeys.availableHours.rawValue] as? [String]
        imageUrls = dictionary[CodingKeys.imageUrls.rawValue] as? [String]
    }
}
