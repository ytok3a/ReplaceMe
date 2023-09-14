//
//  ItemIsOverdueTests.swift
//  ReplaceMeTests
//
//  Created by Cesar Fuentes on 9/14/23.
//

import XCTest
@testable import ReplaceMe

final class ItemIsOverdueTests: XCTestCase {

    func test1() throws {
        // arrange
        let lastReplaced = Date(timeIntervalSince1970: TimeInterval(1694030400)) // 2023-09-06 3PM
        let currDate = Date(timeIntervalSince1970: TimeInterval(1694635200)) // 2023-09-13 3PM
        let item = Item(lastReplaced:lastReplaced, replaceEvery: DateDuration(value: 1, unit: .weeks))
        // act
        let actualOutput = item.isOverdue(currDate: currDate)
        // assert
        XCTAssertEqual(actualOutput, false)
    }
    
    func test2() throws {
        // arrange
        let lastReplaced = Date(timeIntervalSince1970: TimeInterval(1694030400)) // 2023-09-06 3PM
        let currDate = Date(timeIntervalSince1970: TimeInterval(1694635200)) // 2023-09-13 3PM
        let item = Item(lastReplaced:lastReplaced, replaceEvery: DateDuration(value: 2, unit: .weeks))
        // act
        let actualOutput = item.isOverdue(currDate: currDate)
        // assert
        XCTAssertEqual(actualOutput, false)
    }
    
    func test3() throws {
        // arrange
        let lastReplaced = Date(timeIntervalSince1970: TimeInterval(1694030400)) // 2023-09-06 3PM
        let currDate = Date(timeIntervalSince1970: TimeInterval(1695240000)) // 2023-09-20 3PM
        let item = Item(lastReplaced:lastReplaced, replaceEvery: DateDuration(value: 1, unit: .weeks))
        // act
        let actualOutput = item.isOverdue(currDate: currDate)
        // assert
        XCTAssertEqual(actualOutput, true)
    }


}
