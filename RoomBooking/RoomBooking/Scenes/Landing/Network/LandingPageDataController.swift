//
//  LandingPageDataController.swift
//  RoomBooking
//
//  Created by Onur Torna on 20/04/18.
//

import Foundation

class LandingPageDataController: LandingPageDataProvider {

    func getRoomList(with date: Date?,
                     stringDate: String?,
                     completion: @escaping (GetRoomsResponse?, Error?) -> Void) {

        let request = GetRoomsRequest(stringDate: stringDate, date: date)
        NetworkManager.shared.execute(with: request) { (data, response, error) in

            if let error = error {
                completion(nil, error)
            }

            if let data = data {
                if let responseJSON = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]],
                    let response = GetRoomsResponse.init(with: responseJSON) {
                    print(responseJSON)
                    completion(response, nil)
                } else {
                    // Handle Error
                }
            }
        }
    }
}
