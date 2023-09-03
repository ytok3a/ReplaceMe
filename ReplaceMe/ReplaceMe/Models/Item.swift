//
//  Item.swift
//  ReplaceMe
//
//  Created by Cesar Fuentes on 9/2/23.
//

import Foundation
import SwiftData

@Model
class Item {
    @Attribute(.unique) var name: String
    var icon: String
    var lastReplaced: Date
    var replaceEvery: DateDuration
    var remindBefore: DateDuration
    var notes: String
    
    init(name: String = "", icon: String = "", lastReplaced: Date = Date(), replaceEvery: DateDuration = DateDuration(value: 2, unit: .weeks), remindBefore: DateDuration = DateDuration(value: 1, unit: .days), notes: String = "") {
        self.name = name
        self.icon = icon
        self.lastReplaced = lastReplaced
        self.replaceEvery = replaceEvery
        self.remindBefore = remindBefore
        self.notes = notes
    }
    
    func canSave() -> Bool {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }

        guard isValidReminder() else {
            return false
        }

        guard lastReplaced <= Date() else {
            return false
        }

        //TODO: maybe need to check for duplicated names

        return true;
    }
    
    func isValidReminder() -> Bool {
        return replaceEvery.inDays > remindBefore.inDays
    }

    

}
