//
//  Item.swift
//  ReplaceMe
//
//  Created by Cesar Fuentes on 9/2/23.
//

import Foundation

struct Item:  Identifiable {
//    Codable,
    
    let id: String
    let icon: String
    let name: String
    let lastReplaced: Date
    let replaceEvery: DateDuration
    let remindBefore: DateDuration
    let notes: String
    
//    var replaceEvery: DateDuration?
//    var remindBefore: DateDuration?

    
    mutating func isResplaced() {
        // TODO: do something
    }
    
    
}
