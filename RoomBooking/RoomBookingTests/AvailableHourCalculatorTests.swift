//
//  AvailableHourCalculatorTests.swift
//  RoomBookingTests
//
//  Created by Onur Torna on 03/07/18.
//

import XCTest
@testable import RoomBooking

class AvailableHourCalculatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCalculateRoomAvailableHours() {

        let emptyArray: [String] = []

        let emptyDictionary = AvailableHourCalculator.calculateRoomAvailableHours(emptyArray)
        XCTAssertEqual(emptyDictionary, [:])

        let nilDictionary = AvailableHourCalculator.calculateRoomAvailableHours(nil)
        XCTAssertEqual(nilDictionary, nil)

        let firstTestCase = ["07:00 - 07:45" , "18:15 - 19:00"]
        let firstTestResult = AvailableHourCalculator.calculateRoomAvailableHours(firstTestCase)
        let firstExpectedResult: [Int: [Bool]] = [7: [true, true,true,false],
                                   18: [false,true,true,true],
                                   19: [false,false,false,false]]
        XCTAssertEqual(firstTestResult, firstExpectedResult)

        let secondTestCase = ["07:00 - 07:15" , "07:30 - 07:45"]
        let secondTestResult = AvailableHourCalculator.calculateRoomAvailableHours(secondTestCase)
        let secondExpectedResult: [Int: [Bool]] = [7: [true, false,true,false]]
        XCTAssertEqual(secondTestResult, secondExpectedResult)

        let thirdTestCase = ["09:05 - 09:15" , "15:35 - 15:50"]
        let thirdTestResult = AvailableHourCalculator.calculateRoomAvailableHours(thirdTestCase)
        let thirdExpectedResult: [Int: [Bool]] = [9: [true, false,false,false],
                                                  15: [false,false,true,false]]
        XCTAssertEqual(thirdTestResult, thirdExpectedResult)
    }
    
}
