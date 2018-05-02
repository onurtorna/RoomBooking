//
//  Response.swift
//  RoomBooking
//
//  Created by Onur Torna on 20/04/18.
//

protocol Response {

    init?(with jsonArray: [[String: Any]]?)
}
