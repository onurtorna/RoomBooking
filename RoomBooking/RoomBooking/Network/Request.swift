//
//  AppDelegate.swift
//  RoomBooking
//
//  Created by Onur Torna on 19/04/18.
//

import Foundation

protocol Request {
    var path: String                         { get }
    var method: HTTPMethod                   { get }
    var parameters: [String: Any]?           { get }
}

extension Request {
    var method: HTTPMethod                   { return .post }
    var parameters: [String: Any]?           { return nil }
}
