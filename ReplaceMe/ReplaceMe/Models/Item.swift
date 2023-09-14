//
//  Item.swift
//  ReplaceMe
//
//  Created by Cesar Fuentes on 9/2/23.
//

import Foundation
import SwiftData
import UIKit

@Model
class Item {
    @Attribute(.unique) var name: String
    var icon: String
    var lastReplaced: Date
    var replaceEvery: DateDuration
    var remindBefore: DateDuration
    
    
    var notes: String
    var category: String
    var action: String

    
    // TODO: eventually turn into a subclass
    // TODO: add bool to see if it is editable, true by default on init
    // TODO: add disclaimer as well, with year
    
    var disclaimer: String
    var link: String



    // TODO: SORT BY getReplacementDate()
    
    init(name: String = "", icon: String = "♻️", lastReplaced: Date = Date(), replaceEvery: DateDuration = DateDuration(value: 2, unit: .weeks), remindBefore: DateDuration = DateDuration(value: 1, unit: .days), notes: String = "", category: String = "", disclaimer: String = "", action: String = "Replace", link: String = "") {
        self.name = name
        self.icon = icon
        self.lastReplaced = lastReplaced
        self.replaceEvery = replaceEvery
        self.remindBefore = remindBefore
        self.notes = notes
        self.category = category
        self.disclaimer = disclaimer
        self.action = action
        self.link = link
    }
    
    func getReplacementDate() -> Date {
                
        if (replaceEvery.unit == .days) {
            return Calendar.current.date(byAdding: .day, value: replaceEvery.value, to: lastReplaced) ?? Date()
        } else if  (replaceEvery.unit == .weeks) {
            return Calendar.current.date(byAdding: .weekOfYear, value: replaceEvery.value, to: lastReplaced) ?? Date()
        } else if (replaceEvery.unit == .months) {
            return Calendar.current.date(byAdding: .month, value: replaceEvery.value, to: lastReplaced) ?? Date()
        } else if (replaceEvery.unit == .years) {
            return Calendar.current.date(byAdding: .year, value: replaceEvery.value, to: lastReplaced) ?? Date()
        } else {
            print("ERROR in \(name).getReplacementDate()")
            return Date() // TODO: throw error
        }
                
    }
    
    func getRemainingTime(currDate: Date = Date()) -> DateComponents {
        
        // note that items go from "1 day remaining" to "replace today" to "1 day overdue"
        let replacementDate = getReplacementDate()
        var timeRemaining = Calendar.current.dateComponents([.year, .month, .weekOfYear, .day], from: currDate, to: replacementDate)
        return timeRemaining
        
    }

    
    func getRemainingTimeAsString() -> String {
        
        // todo: make a remaining time functino
        
        var timeRemaining = Calendar.current.dateComponents([.year, .month, .weekOfYear, .day], from: Date(), to: getReplacementDate())
        timeRemaining.day! += 1
//        print("timeRemaining for \(name): \(timeRemaining)")

        let year = timeRemaining.year ?? 0
        let month = timeRemaining.month ?? 0
        let week = timeRemaining.weekOfYear ?? 0
        let day = timeRemaining.day ?? 0
        
        // get singular unit and value (rounded up)
        var value: Int = 0
        var unit: String = ""
        
        var isOverdue = ""
        
        /// TODO: if any of them are negative, say that they are that time unit overdue
        /// TODO: or if they are all zero, move the date up by 1 day (negative)
        if (year < 0 || month < 0 || week < 0 || day < 0 ) {
            isOverdue = " overdue"
            
            if (year < 0) {
                value = year*(-1)
                unit = "years"
            } else if (month < 0) {
                value = month*(-1)
                unit = "months"
            } else if (week < 0) {
                value = week*(-1)
                unit = "weeks"
            } else if (day < 0) {
                value = day*(-1)
                unit = "days"
            }
        } else if (year > 0 || month >= 4) {
            value = year
            if (month >= 4) {
                value += 1
            }
            unit = "years"
        } else if (month > 0 || week >= 3) {
            value = month
            if (week >= 3) {
                value += 1
            }
            unit = "months"
        } else if (week > 0 || day >= 5) {
            value = week
            if (day >= 5) {
                value += 1
            }
            unit = "weeks"
        } else {
            value = day
            unit = "days"
        }

        // remove s if plural (same logic in DurationDatePicker)
        var x = "\(value) \(unit)"
        if (value == 1) {
            x.removeLast()
        }
        
        x = x + isOverdue
        
        return x
        
    }
    
    func isOverdue() -> Bool {
        
        var timeRemaining = Calendar.current.dateComponents([.year, .month, .weekOfYear, .day], from: Date(), to: getReplacementDate())
        timeRemaining.day! += 1
        
//        print("  (checking overdue...) timeRemaining for \(name): \(timeRemaining)")

        let year = timeRemaining.year ?? 0
        let month = timeRemaining.month ?? 0
        let week = timeRemaining.weekOfYear ?? 0
        let day = timeRemaining.day ?? 0

        if (year < 0 || month < 0 || week < 0 || day < 0 ) {
            return true
        } else {
            return false
        }
        
    }
    
    func isNameUnique(items: [Item]) -> Bool {
        
        // TODO: implement this
        return true
    }
    
    
    func canSave(items: [Item]) -> Bool {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }

        guard isValidReminder() else {
            return false
        }

        guard lastReplaced <= Date() else {
            return false
        }

        guard isNameUnique(items: items) else {
            return false
        }

        return true;
    }
    
    func isValidReminder() -> Bool {
        return replaceEvery.inDays > remindBefore.inDays
    }

}

extension Date {
    func getAsString() -> String {
        
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "MMM d, y" // E,
        return formatter3.string(from: self)
        
    }
    
//    static func - (lhs: Date, rhs: Date) -> TimeInterval {
//        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
//    }

    
}

