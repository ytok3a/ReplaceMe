//
//  ItemGetRemainingTimeString.swift
//  ReplaceMeTests
//
//  Created by Cesar Fuentes on 9/13/23.
//

import XCTest
@testable import ReplaceMe

final class ItemGetRemainingTimeString: XCTestCase {

    func test1() throws {
        // arrange
        let lastReplaced = Date(timeIntervalSince1970: TimeInterval(1694030400)) // 2023-09-06 3PM
        let currDate = Date(timeIntervalSince1970: TimeInterval(1694635200)) // 2023-09-13 3PM
        let item = Item(lastReplaced:lastReplaced, replaceEvery: DateDuration(value: 1, unit: .weeks))
        // act
        let actualOutput = item.getRemainingTimeAsString(currDate: currDate)
        // assert
        XCTAssertEqual(actualOutput, "Replace today")
    }
    
    func test2() throws {
        // arrange
        let lastReplaced = Date(timeIntervalSince1970: TimeInterval(1694030400)) // 2023-09-06 3PM
        let currDate = Date(timeIntervalSince1970: TimeInterval(1694635200)) // 2023-09-13 3PM
        let item = Item(lastReplaced:lastReplaced, replaceEvery: DateDuration(value: 2, unit: .weeks))
        // act
        let actualOutput = item.getRemainingTimeAsString(currDate: currDate)
        // assert
        XCTAssertEqual(actualOutput, "1 week left")
    }
    
    func test3() throws {
        // arrange
        let lastReplaced = Date(timeIntervalSince1970: TimeInterval(1694030400)) // 2023-09-06 3PM
        let currDate = Date(timeIntervalSince1970: TimeInterval(1695240000)) // 2023-09-20 3PM
        let item = Item(lastReplaced:lastReplaced, replaceEvery: DateDuration(value: 1, unit: .weeks))
        // act
        let actualOutput = item.getRemainingTimeAsString(currDate: currDate)
        // assert
        XCTAssertEqual(actualOutput, "1 week overdue")
    }
    
    // CASE: rounding feature

    func test4() throws {
        // arrange
        let lastReplaced = Date(timeIntervalSince1970: TimeInterval(1694030400)) // 2023-09-06 3PM
        let currDate = Date(timeIntervalSince1970: TimeInterval(1694635200)) // 2023-09-13 3PM
        let item = Item(lastReplaced:lastReplaced, replaceEvery: DateDuration(value: 2, unit: .years))
        // act
        print(item.getRemainingTime(currDate: currDate))
        let actualOutput = item.getRemainingTimeAsString(currDate: currDate)
        // assert
        XCTAssertEqual(actualOutput, "2 years left")
    }
    
    func test_() throws {
        // arrange
        // act
        // assert
    }
        
    // 2 years left
    // 1 year left
    // 2 months left
    // 1 month left
    // 2 weeks left
    // 1 week left
    // 2 days left
    // 1 day left
    // Replace today
    // 1 day overdue
    // 2 days overdue
    // 1 week overdue
    // 2 weeks overdue
    // 1 month overdue
    // 2 months overdue
    // 1 year overdue
    // 2 years overdue


}
