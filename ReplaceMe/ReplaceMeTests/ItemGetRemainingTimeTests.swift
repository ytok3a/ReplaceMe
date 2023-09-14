//
//  ItemGetRemainingTimeTests.swift
//  ReplaceMeTests
//
//  Created by Cesar Fuentes on 9/13/23.
//

import XCTest
@testable import ReplaceMe

final class ItemGetRemainingTimeTests: XCTestCase {

    // MARK: 1 Day Left
    
    func test1() throws {
        // arrange
        let lastReplaced = Date(timeIntervalSince1970: TimeInterval(1694030400)) // 2023-09-06 3PM
        let currDate = Date(timeIntervalSince1970: TimeInterval(1694635200)) // 2023-09-13 3PM
        let item = Item(lastReplaced:lastReplaced, replaceEvery: DateDuration(value: 1, unit: .weeks))
        // act
        let actualOutput = item.getRemainingTime(currDate: currDate)
        var expectedOutput = DateComponents()
        expectedOutput.year = 0
        expectedOutput.month = 0
        expectedOutput.weekOfYear = 0
        expectedOutput.day = 0
        // assert
        XCTAssertEqual(actualOutput, expectedOutput)
    }
    
    // MARK: 1 Week Left
    
    func test2() throws {
        // arrange
        let lastReplaced = Date(timeIntervalSince1970: TimeInterval(1694030400)) // 2023-09-06 3PM
        let currDate = Date(timeIntervalSince1970: TimeInterval(1694635200)) // 2023-09-13 3PM
        let item = Item(lastReplaced:lastReplaced, replaceEvery: DateDuration(value: 2, unit: .weeks))
        // act
        let actualOutput = item.getRemainingTime(currDate: currDate)
        var expectedOutput = DateComponents()
        expectedOutput.year = 0
        expectedOutput.month = 0
        expectedOutput.weekOfYear = 1
        expectedOutput.day = 0
        // assert
        XCTAssertEqual(actualOutput, expectedOutput)
    }
    
    // MARK: 1 Day Left
    
    func test3() throws {
        // arrange
        let lastReplaced = Date(timeIntervalSince1970: TimeInterval(1694030400)) // 2023-09-06 3PM
        let currDate = Date(timeIntervalSince1970: TimeInterval(1694548800)) // 2023-09-12 3PM
        let item = Item(lastReplaced:lastReplaced, replaceEvery: DateDuration(value: 1, unit: .weeks))
        // act
        let actualOutput = item.getRemainingTime(currDate: currDate)
        var expectedOutput = DateComponents()
        expectedOutput.year = 0
        expectedOutput.month = 0
        expectedOutput.weekOfYear = 0
        expectedOutput.day = 1
        // assert
        XCTAssertEqual(actualOutput, expectedOutput)
    }

    // MARK: 0 Day Left
    func test4() throws {
        // arrange
        let lastReplaced = Date(timeIntervalSince1970: TimeInterval(1694030400)) // 2023-09-06 3PM
        let currDate = Date(timeIntervalSince1970: TimeInterval(1694635200)) // 2023-09-13 3PM
        let item = Item(lastReplaced:lastReplaced, replaceEvery: DateDuration(value: 1, unit: .weeks))
        // act
        let actualOutput = item.getRemainingTime(currDate: currDate)
        var expectedOutput = DateComponents()
        expectedOutput.year = 0
        expectedOutput.month = 0
        expectedOutput.weekOfYear = 0
        expectedOutput.day = 0
        // assert
        XCTAssertEqual(actualOutput, expectedOutput)
    }
    
    // MARK: 1 Day Overdue

    func test5() throws {
        // arrange
        let lastReplaced = Date(timeIntervalSince1970: TimeInterval(1694030400)) // 2023-09-06 3PM
        let currDate = Date(timeIntervalSince1970: TimeInterval(1694721600)) // 2023-09-14 3PM
        let item = Item(lastReplaced:lastReplaced, replaceEvery: DateDuration(value: 1, unit: .weeks))
        // act
        let actualOutput = item.getRemainingTime(currDate: currDate)
        var expectedOutput = DateComponents()
        expectedOutput.year = 0
        expectedOutput.month = 0
        expectedOutput.weekOfYear = 0
        expectedOutput.day = -1
        // assert
        XCTAssertEqual(actualOutput, expectedOutput)
    }
    
    // MARK: 1 Week Overdue

    func test6() throws {
        // arrange
        let lastReplaced = Date(timeIntervalSince1970: TimeInterval(1694030400)) // 2023-09-06 3PM
        let currDate = Date(timeIntervalSince1970: TimeInterval(1695240000)) // 2023-09-20 3PM
        let item = Item(lastReplaced:lastReplaced, replaceEvery: DateDuration(value: 1, unit: .weeks))
        // act
        let actualOutput = item.getRemainingTime(currDate: currDate)
        var expectedOutput = DateComponents()
        expectedOutput.year = 0
        expectedOutput.month = 0
        expectedOutput.weekOfYear = -1
        expectedOutput.day = 0
        // assert
        XCTAssertEqual(actualOutput, expectedOutput)
    }
    
    // TODO: add test cases for different time
    // TODO: add more test cases for different units
    

}
