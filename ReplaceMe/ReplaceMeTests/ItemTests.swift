//
//  ItemTests.swift
//  ReplaceMeTests
//
//  Created by Cesar Fuentes on 9/12/23.
//

import XCTest
@testable import ReplaceMe

final class ItemTests: XCTestCase {
    


    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testGetReplacementDate() throws {
        
        // negatives
        // leap years
        // that weird time thing from that one video (timezones)
        
        // TEST CASE: 1 Day
        let item1 = Item(lastReplaced:Date(), replaceEvery: DateDuration(value: 1, unit: .days))
        let expectedOutput1 = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
        XCTAssertEqual(item1.getReplacementDate(), expectedOutput1)

        // TEST CASE: 1 Week
        let item2 = Item(lastReplaced:Date(), replaceEvery: DateDuration(value: 1, unit: .weeks))
        let expectedOutput2 = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: Date()) ?? Date()
        XCTAssertEqual(item2.getReplacementDate(), expectedOutput2)

        // TEST CASE: 1 Month
        let item3 = Item(lastReplaced:Date(), replaceEvery: DateDuration(value: 1, unit: .months))
        let expectedOutput3 = Calendar.current.date(byAdding: .month, value: 1, to: Date()) ?? Date()
        XCTAssertEqual(item3.getReplacementDate(), expectedOutput3)
        
        // TEST CASE: 1 Year
        let item4 = Item(lastReplaced:Date(), replaceEvery: DateDuration(value: 1, unit: .months))
        let expectedOutput4 = Calendar.current.date(byAdding: .year, value: 1, to: Date()) ?? Date()
        XCTAssertEqual(item4.getReplacementDate(), expectedOutput4)
        
        
//
        
        // TEST CASE: 1 Year
        let item = Item(lastReplaced:Date(), replaceEvery: DateDuration(value: 1, unit: .months))
        let expectedOutput = Calendar.current.date(byAdding: .month, value: 1, to: Date()) ?? Date()
        XCTAssertEqual(item.getReplacementDate(), expectedOutput)


        print("testGetReplacementDate()... passed")
        
        

    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
