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
    
    var body: some Scene {
        WindowGroup {
            ListView()
                .modelContainer(for: Item.self)
        }
    }
    
}
