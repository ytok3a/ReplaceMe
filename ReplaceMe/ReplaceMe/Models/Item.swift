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


    // TODO: SORT BY getReplacementDate()
    
    init(name: String = "", icon: String = "♻️", lastReplaced: Date = Date(), replaceEvery: DateDuration = DateDuration(value: 2, unit: .weeks), remindBefore: DateDuration = DateDuration(value: 1, unit: .days), notes: String = "", category: String = "", disclaimer: String = "", action: String = "Replace") {
        self.name = name
        self.icon = icon
        self.lastReplaced = lastReplaced
        self.replaceEvery = replaceEvery
        self.remindBefore = remindBefore
        self.notes = notes
        self.category = category
        self.disclaimer = disclaimer
        self.action = action
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
    
    func getRemainingTimeAsString() -> String {
        
        var timeRemaining = Calendar.current.dateComponents([.year, .month, .weekOfYear, .day], from: Date(), to: getReplacementDate())
        timeRemaining.day! += 1
        print("timeRemaining: \(timeRemaining)")

        let year = timeRemaining.year ?? 0
        let month = timeRemaining.month ?? 0
        let week = timeRemaining.weekOfYear ?? 0
        let day = timeRemaining.day ?? 0
        
        // get singular unit and value (rounded up)
        var value: Int
        var unit: String

        if (year > 0 || month >= 4) {
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
        
        return x
        
    }
    
    func getPercentage() -> Double {
        let replacementDate = getReplacementDate()
        
        // get remaining days in replacement period
        var timeRemainingInDays  = Calendar.current.dateComponents([.day], from: Date(), to: replacementDate)
        timeRemainingInDays.day! += 1
        
        // get the total days in the replacement period
        let repacementPeriodInDays = Calendar.current.dateComponents([.day], from: lastReplaced, to: replacementDate)
        //        repacementPeriodInDays.day! += 1

        // divide
        let percentRemaining = Double(timeRemainingInDays.day ?? 0) / Double(repacementPeriodInDays.day ?? 1)
        
        return percentRemaining

    }
    
    func getColor() -> UIColor {
        
        let p = getPercentage()
        
        if (p >= 0.9) {
            return UIColor.green
        } else if (p >= 0.8) {
            return UIColor.green
        } else if (p >= 0.6) {
            return UIColor.yellow
        } else if (p >= 0.5) {
            return UIColor.yellow
        }else if (p >= 0.35) {
            return UIColor.orange
        }else if (p >= 0.15) {
            return UIColor.red
        }else if (p >= 0.05) {
            return UIColor.red
        }else if (p >= 0) {
            return UIColor.white
        }
                
        return UIColor(red: 1.0 , green: 1.0, blue: 1.0, alpha: 1.0)
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

