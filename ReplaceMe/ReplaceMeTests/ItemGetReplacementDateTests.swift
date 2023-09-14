//
//  ItemGetReplacementDateTests.swift
//  ReplaceMeTests
//
//  Created by Cesar Fuentes on 9/13/23.
//

import XCTest
@testable import ReplaceMe

final class ItemGetReplacementDateTests: XCTestCase {
    
    // MARK: Static Dates
    
    func test1() throws {
        // arrange
        let lastReplaced = Date(timeIntervalSince1970: TimeInterval(1694635200)) // 2023-09-13 3PM
        let item = Item(lastReplaced:lastReplaced, replaceEvery: DateDuration(value: 1, unit: .days))
        // act
        let actualOutput = item.getReplacementDate()
        let expectedOutput = Date(timeIntervalSince1970: TimeInterval(1694721600)) // 2023-09-14 3PM
        // assert
        XCTAssertEqual(actualOutput, expectedOutput)
    }
    
    func test2() throws {
        // arrange
        let lastReplaced = Date(timeIntervalSince1970: TimeInterval(1694635200)) // 2023-09-13 3PM
        let item = Item(lastReplaced:lastReplaced, replaceEvery: DateDuration(value: 1, unit: .weeks))
        // act
        let actualOutput = item.getReplacementDate()
        let expectedOutput = Date(timeIntervalSince1970: TimeInterval(1695240000)) // 2023-09-20 3PM
        // assert
        XCTAssertEqual(actualOutput, expectedOutput)
    }

    func test3() throws {
        // arrange
        let lastReplaced = Date(timeIntervalSince1970: TimeInterval(1694635200)) // 2023-09-13 3PM
        let item = Item(lastReplaced:lastReplaced, replaceEvery: DateDuration(value: 1, unit: .months))
        // act
        let actualOutput = item.getReplacementDate()
        let expectedOutput = Date(timeIntervalSince1970: TimeInterval(1697227200)) // 2023-10-13 3PM
        // assert
        XCTAssertEqual(actualOutput, expectedOutput)
    }
    
    func test4() throws {
        // arrange
        let lastReplaced = Date(timeIntervalSince1970: TimeInterval(1694635200)) // 2023-09-13 3PM
        let item = Item(lastReplaced:lastReplaced, replaceEvery: DateDuration(value: 1, unit: .years))
        // act
        let actualOutput = item.getReplacementDate()
        let expectedOutput = Date(timeIntervalSince1970: TimeInterval(1726257600)) // 2024-9-13 3PM
        // assert
        XCTAssertEqual(actualOutput, expectedOutput)
    }
    
    // MARK: Months (no standard number of days)

    func test5() throws {
        // arrange
        let lastReplaced = Date(timeIntervalSince1970: TimeInterval(1677618000)) // 2023-02-28 3PM
        let item = Item(lastReplaced:lastReplaced, replaceEvery: DateDuration(value: 1, unit: .months))
        // act
        let actualOutput = item.getReplacementDate()
        let expectedOutput = Date(timeIntervalSince1970: TimeInterval(1680033600)) // 2023-03-28 3PM
        // assert
        XCTAssertEqual(actualOutput, expectedOutput)
    }

    
    func test_() throws {
        // arrange
        // act
        // assert
    }

}


//// negatives
//// leap years
//// that weird time thing from that one video (timezones)
//
//
//// TEST CASE: 1 Week
//let item2 = Item(lastReplaced:Date(), replaceEvery: DateDuration(value: 1, unit: .weeks))
//let expectedOutput2 = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: Date()) ?? Date()
//XCTAssertEqual(item2.getReplacementDate(), expectedOutput2)
//
//// TEST CASE: 1 Month
//let item3 = Item(lastReplaced:Date(), replaceEvery: DateDuration(value: 1, unit: .months))
//let expectedOutput3 = Calendar.current.date(byAdding: .month, value: 1, to: Date()) ?? Date()
//XCTAssertEqual(item3.getReplacementDate(), expectedOutput3)
//
//// TEST CASE: 1 Year
//let item4 = Item(lastReplaced:Date(), replaceEvery: DateDuration(value: 1, unit: .months))
//let expectedOutput4 = Calendar.current.date(byAdding: .year, value: 1, to: Date()) ?? Date()
//XCTAssertEqual(item4.getReplacementDate(), expectedOutput4)
//
//
////
//
//// TEST CASE: 1 Year
//let item = Item(lastReplaced:Date(), replaceEvery: DateDuration(value: 1, unit: .months))
//let expectedOutput = Calendar.current.date(byAdding: .month, value: 1, to: Date()) ?? Date()
//XCTAssertEqual(item.getReplacementDate(), expectedOutput)
