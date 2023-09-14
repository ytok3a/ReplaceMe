//
//  ItemIsNameUniqueTests.swift
//  ReplaceMeTests
//
//  Created by Cesar Fuentes on 9/14/23.
//

import XCTest
@testable import ReplaceMe

final class ItemIsNameUniqueTests: XCTestCase {

    func test1() throws {
        // arrange
        var items: [Item] = []
        let item: Item = Item(name: "Fire Extinguisher")
        items.append(item)
        // act
        let actualOutput = item.isNameUnique(items: items)
        // assert
        XCTAssertEqual(actualOutput, false)
    }
    
    func test2() throws {
        // arrange
        var items: [Item] = []
        let item: Item = Item(name: "Fire Extinguisher")
        // act
        let actualOutput = item.isNameUnique(items: items)
        // assert
        XCTAssertEqual(actualOutput, true)
    }

    func test3() throws {
        // arrange
        var items: [Item] = []
        let item: Item = Item(name: "Fire Extinguisher")
        let item2: Item = Item(name: "Toothbrush")
        items.append(item)
        items.append(item2)
        // act
        let item3: Item = Item(name: "Air Filter")
        let actualOutput = item3.isNameUnique(items: items)
        // assert
        XCTAssertEqual(actualOutput, true)
    }
}
