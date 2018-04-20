//
//  LandingPageDataProvider.swift
//  RoomBooking
//
//  Created by Onur Torna on 20/04/18.
//

import Foundation

protocol LandingPageDataProvider {

    func getRoomList(with date: Date?,
                     stringDate: String?,
                     completion: @escaping (GetRoomsResponse?, Error?) -> Void)
}
