//
//  ReplaceMeApp.swift
//  ReplaceMe
//
//  Created by Cesar Fuentes on 9/2/23.
//

import SwiftUI
import SwiftData

@main
struct ReplaceMeApp: App {
    
//    let modelContainer: ModelContainer
//    
//    init() {
//        do {
//            modelContainer = try ModelContainer(for: Item.self)
//        } catch {
//            fatalError("Could not initialize ModelContainer")
//        }
//    }

    
    var body: some Scene {
        WindowGroup {
            ListView()
                .modelContainer(for: Item.self)
        }
    }
}
