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
            
            let item = Item(name: "Fire Extinguisher", icon: "🧯")
            context.insert(item)
            
            let item2 = Item(name: "Toothbrush", icon: "🪥", lastReplaced: Calendar(identifier: .iso8601).date(byAdding: .weekOfYear, value: -1, to: Date())!
)
            context.insert(item2)


        }
        
        return container
    } catch {
        fatalError("")
    }
    
}()
