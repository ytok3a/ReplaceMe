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
    
    init(name: String = "", icon: String = "♻️", lastReplaced: Date = Date(), replaceEvery: DateDuration = DateDuration(value: 2, unit: .weeks), remindBefore: DateDuration = DateDuration(value: 1, unit: .days), notes: String = "") {
        self.name = name
        self.icon = icon
        self.lastReplaced = lastReplaced
        self.replaceEvery = replaceEvery
        self.remindBefore = remindBefore
        self.notes = notes
    }
    
    func getReplacementDate() -> Date {
        
        var nextReplaced: Date = Date()
        
        if (replaceEvery.unit == .days) {
            nextReplaced = Calendar.current.date(byAdding: .day, value: replaceEvery.value, to: lastReplaced) ?? Date() //TODO: is this correct?
        } else if  (replaceEvery.unit == .weeks) {
            nextReplaced = Calendar.current.date(byAdding: .weekOfYear, value: replaceEvery.value, to: lastReplaced) ?? Date()
        } else if (replaceEvery.unit == .months) {
            nextReplaced = Calendar.current.date(byAdding: .month, value: replaceEvery.value, to: lastReplaced) ?? Date()
        } else if (replaceEvery.unit == .years) {
            nextReplaced = Calendar.current.date(byAdding: .year, value: replaceEvery.value, to: lastReplaced) ?? Date()
        }
        
        return nextReplaced;
        
    }
    
    func getRemainingTime() -> String {
        
        var timeRemaining = Calendar.current.dateComponents([.year, .month, .weekOfYear, .day], from: Date(), to: getReplacementDate())
        
        // it's not counting today, but it should
        timeRemaining.day! += 1

        
        let year = timeRemaining.year ?? 0
        let y = (year != 0) ? "\(year)Y" : ""
        
        let month = timeRemaining.month ?? 0
        let m = (month != 0) ? "\(month)M" : ""
        
        let week = timeRemaining.weekOfYear ?? 0
        let w = (week != 0) ? "\(week)W" : ""

        let day = timeRemaining.day ?? 0
        let d = (day != 0) ? "\(day)D" : ""
        
        return "\(y) \(m) \(w) \(d)".trimmingCharacters(in: .whitespaces)
        
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

