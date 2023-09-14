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
        let timeRemaining = Calendar.current.dateComponents([.year, .month, .weekOfYear, .day], from: currDate, to: replacementDate)
        return timeRemaining
        
    }
    
    func roundPositiveDateComponentsAsString(dateComps: DateComponents) -> String {
        
        var value: Int = 0
        var unit: String = ""

        
        if (dateComps.year! > 0 || dateComps.month! >= 4) {
            value = dateComps.year!
            if (dateComps.month! >= 4) {
                value += 1
            }
            unit = "years"

        } else if (dateComps.month! > 0 || dateComps.weekOfYear! >= 3) {
            value = dateComps.month!
            if (dateComps.weekOfYear! >= 3) {
                value += 1
            }
            unit = "months"
        } else if (dateComps.weekOfYear! > 0 || dateComps.day! >= 5) {
            value = dateComps.weekOfYear!
            if (dateComps.day! >= 5) {
                value += 1
            }
            unit = "weeks"
        } else {
            value = dateComps.day!
            unit = "days"
        }
        
        // TODO: maybe turn into DateDuration(value: value, unit: unit) to use .asString(), but out of scope
        
        var x = "\(value) \(unit)"
        
        // remove s if plural
        if (value == 1) {
            x.removeLast()
        }
        
        return x

    }

    
    func getRemainingTimeAsString(currDate: Date = Date()) -> String {
        
        var timeRemaining = getRemainingTime(currDate: currDate)
                        
        if (timeRemaining.year! < 0 || timeRemaining.month! < 0 || timeRemaining.weekOfYear! < 0 || timeRemaining.day! < 0 ) { // CASE: overdue

            // turn positive and round
            timeRemaining.year = timeRemaining.year!*(-1)
            timeRemaining.month = timeRemaining.month!*(-1)
            timeRemaining.weekOfYear = timeRemaining.weekOfYear!*(-1)
            timeRemaining.day = timeRemaining.day!*(-1)
            
            let roundedTimeRemainingString = roundPositiveDateComponentsAsString(dateComps: timeRemaining)
            return roundedTimeRemainingString + " overdue"
            
        } else if (timeRemaining.year! == 0 && timeRemaining.month! == 0 && timeRemaining.weekOfYear! == 0 && timeRemaining.day! == 0 ) { 
            
            // CASE: due today
            return "Replace today"
            
        } else { // CASE: still time left
            
            let roundedTimeRemainingString = roundPositiveDateComponentsAsString(dateComps: timeRemaining)
            return roundedTimeRemainingString + " left"
        }
                
    }
    
    func isOverdue(currDate: Date = Date()) -> Bool {
        
        let timeRemaining = getRemainingTime(currDate: currDate)

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
        for item in items {
            if (name == item.name) {
                return false
            }
        }
        return true
    }
    
    func isValidReminder() -> Bool {
        // TODO: create test cases
        return replaceEvery.inDays > remindBefore.inDays
    }

    func canSave(items: [Item]) -> Bool {
        
        // TODO: send message too
        
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
            // "Enter an item name."
        }

        guard isValidReminder() else {
            return false
            // "Reminders must be set earlier than replacement."
        }

        guard lastReplaced <= Date() else {
            return false
            // "The last time you replaced this can't be after today."
        }

        guard isNameUnique(items: items) else {
            return false
            // "This item name already exists"
            // TODO: make sure that created item is not in items list to compare
        }

        return true;
    }
    

}

extension Date {
    func getAsString() -> String {
        
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "MMM d, y" // E,
        return formatter3.string(from: self)
        
    }
        
}

