//
//  NetworkManager.swift
//  RoomBooking
//
//  Created by Onur Torna on 19/04/18.
//

import Foundation

final class NetworkManager: NSObject {

    private enum Constants {
        static let baseUrl = "https://challenges.1aim.com/roombooking_app/"
        static let contentTypeKey = "Content-Type"
        static let jsonContentTypeValue = "application/json"
    }

    static let shared = NetworkManager()
    private let session = URLSession.shared


    func execute(with request: Request,
                 completion: @escaping (Data?, URLResponse?, Error?) -> Void) {

        let request = NetworkManager.createUrlRequest(with: request)
        let task = session.dataTask(with: request) { (data, response, error) in

            completion(data, response, error)
        }

        task.resume()
    }

    func getRoomList(with date: Date?,
                     stringDate: String?,
                     completion: @escaping (GetRoomsResponse?, Error?) -> Void) {

        let request = GetRoomsRequest(stringDate: "today", date: date)
        NetworkManager.shared.execute(with: request) { (data, response, error) in

            if let error = error {
                completion(nil, error)
            }

            if let data = data {
                if let responseJSON = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]],
                    let response = GetRoomsResponse.init(with: responseJSON) {
                    completion(response, nil)
                } else {
                    // Handle Error
                }
            }
        }
    }

    static func createUrlRequest(with request: Request) -> URLRequest {

        let url = URL(string: Constants.baseUrl)?.appendingPathComponent(request.path)
        var urlRequest = URLRequest(url: url!)

        urlRequest.httpMethod = request.method.rawValue

        if let parameters = request.parameters {
            urlRequest.setValue(Constants.jsonContentTypeValue,
                                forHTTPHeaderField: Constants.jsonContentTypeValue)
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        }

        return urlRequest
    }
}
