//
//  PreviewHelpers.swift
//  ReplaceMe
//
//  Created by Cesar Fuentes on 9/2/23.
//

import Foundation
import SwiftData

let previewContainer: ModelContainer = {
    do {
        let container = try ModelContainer(for: Item.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        Task { @MainActor in
            let context = container.mainContext
            
            // MARK: added presets
            for item in presets {
                context.insert(item)
            }

            let item1 = Item(name: "Pill Container",
                            icon: "💊",
                            lastReplaced: Calendar.current.date(byAdding: .day, value: -8, to: Date()) ?? Date() ,
                            replaceEvery: DateDuration(value: 1, unit: .weeks))
            context.insert(item1)

            let item2 = Item(name: "Lightbulb",
                            icon: "💡",
                            lastReplaced: Calendar.current.date(byAdding: .day, value: -3, to: Date()) ?? Date() ,
                            replaceEvery: DateDuration(value: 1, unit: .weeks))
            context.insert(item2)

        }
        
        return container
    } catch {
        fatalError("")
    }
    
}()


