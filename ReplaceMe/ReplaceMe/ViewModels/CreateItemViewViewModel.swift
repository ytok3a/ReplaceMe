//
//  CreateItemViewViewModel.swift
//  ReplaceMe
//
//  Created by Cesar Fuentes on 9/2/23.
//

import Foundation

class CreateItemViewViewModel: ObservableObject {
    @Published var icon = "🧯"
    @Published var name = ""
    @Published var lastReplaced = Date()
    @Published var replaceEvery = DateDuration(value: 2, unit: .weeks)
    @Published var remindBefore = DateDuration(value: 1, unit: .days)
    @Published var notes = ""
    
    @Published var preset = "None"

    @Published var isPickerVisible = false
    @Published var isPicker2Visible = false
    @Published var showAlert = false

    init() {}
    
    func save() {
        guard canSave else {
            return
        }
        
        let newId = UUID().uuidString
        let newItem = Item(id: newId,
                           icon: icon,
                           name: name,
                           lastReplaced: lastReplaced,
                           replaceEvery: replaceEvery,
                           remindBefore: remindBefore,
                           notes: notes)
        
    }
    var canSave: Bool {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        guard isValidReminder() else {
            return false
        }
        
        guard lastReplaced <= Date() else {
            return false
        }
        
        return true;
    }
    
    func isValidReminder() -> Bool {
        return replaceEvery.inDays > remindBefore.inDays
    }
    
    
    
//    TODO: use this
    func getNextReplacementDate() -> Date {
        
        var nextReplaced: Date = Date()

        if (replaceEvery.unit == .days) {
            nextReplaced = Calendar.current.date(byAdding: .day, value: replaceEvery.value, to: lastReplaced) ?? Date() //TODO: is this correct?
        } else if  (replaceEvery.unit == .weeks) {
            nextReplaced = Calendar.current.date(byAdding: .weekOfYear, value: replaceEvery.value, to: lastReplaced) ?? Date()
        } else if (replaceEvery.unit == .months) {
            nextReplaced = Calendar.current.date(byAdding: .year, value: replaceEvery.value, to: lastReplaced) ?? Date()
        }

        return nextReplaced;

    }
    
    // TODO: make notification on create and update on save
    
}
