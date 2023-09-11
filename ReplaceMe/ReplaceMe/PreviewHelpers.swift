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
            
            let item = Item(name: "Smoke Alarm Batteries",
                            icon: "🔋",
                            lastReplaced: Date(),
                            replaceEvery: DateDuration(value: 1, unit: .years),
                            remindBefore: DateDuration(value: 1, unit: .weeks),
                            notes: "",
                            category: "",
                            disclaimer: "The National Fire Protection Association (NFPA) recommends changing the batteries in your smoke detectors every year. ",
                            link: "https://www.nfpa.org/News-and-Research/Publications-and-media/Blogs-Landing-Page/Safety-Source/Blog-Posts/2022/03/11/Change-your-clocks-check-your-smoke-alarm-batteries#:~:text=Smoke%20alarms%20with%20non%2Dreplaceable,at%20least%20once%20a%20year.")
            context.insert(item)
            
            let item2 = Item(name: "Smoke Alarm Batteries 222",
                            icon: "🔋",
                            lastReplaced: Date(),
                            replaceEvery: DateDuration(value: 1, unit: .years),
                            remindBefore: DateDuration(value: 1, unit: .weeks),
                            notes: "",
                            category: "",
                            disclaimer: "The National Fire Protection Association (NFPA) recommends changing the batteries in your smoke detectors every year. ",
                            link: "https://www.nfpa.org/News-and-Research/Publications-and-media/Blogs-Landing-Page/Safety-Source/Blog-Posts/2022/03/11/Change-your-clocks-check-your-smoke-alarm-batteries#:~:text=Smoke%20alarms%20with%20non%2Dreplaceable,at%20least%20once%20a%20year.")

            
//            let item2 = Item(name: "Toothbrush", icon: "🪥", lastReplaced: Calendar(identifier: .iso8601).date(byAdding: .weekOfYear, value: -1, to: Date())!
//)
            context.insert(item2)


        }
        
        return container
    } catch {
        fatalError("")
    }
    
}()
