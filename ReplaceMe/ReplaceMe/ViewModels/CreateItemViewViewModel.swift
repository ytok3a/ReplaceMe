//
//  CreateItemViewViewModel.swift
//  ReplaceMe
//
//  Created by Cesar Fuentes on 9/2/23.
//

import Foundation

class CreateItemViewViewModel: ObservableObject {
    @Published var name = ""
    @Published var lastReplaced = Date()
    @Published var replaceEvery = DateDuration(value: 2, unit: .weeks)
    @Published var remindBefore = DateDuration(value: 4, unit: .days)

    @Published var notes = ""
    
    @Published var isPickerVisible = false
    @Published var isPicker2Visible = false



    init() {}
    
    func save() {
        
    }
    
    // TODO: make notification on create and update on save
    
}
