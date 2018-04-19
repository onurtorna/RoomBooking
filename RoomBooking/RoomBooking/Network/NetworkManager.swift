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

    func execute(with request: Request) {

        let request = NetworkManager.createUrlRequest(with: request)

        let task = session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                if let responseJSON = responseJSON as? [String: Any] {
                    print(responseJSON)
                }
            }
        }
        task.resume()
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
