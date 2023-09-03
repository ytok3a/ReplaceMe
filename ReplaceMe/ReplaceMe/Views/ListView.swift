//
//  ContentView.swift
//  ReplaceMe
//
//  Created by Cesar Fuentes on 9/2/23.
//

import SwiftUI
import SwiftData

struct ListView: View {
    @State private var sheetIsPresented = false

    @Query var items: [Item]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationView {
            VStack {
                
                List {
                    ForEach (items) { item in
                        HStack {
                            
                            NavigationLink {
                                ReadItemView(item: item)
                            } label: {
                                Text(item.name)
                            }
                        }
                    }
                }
                
            }
            .navigationTitle("Your Items")
            .toolbar {
                Button {
//                    CreateItemView(item: item())
                    sheetIsPresented.toggle()
//                    viewModel.showingCreateItemView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            
// TODO: this still might be needed
            
            .sheet(isPresented: $sheetIsPresented) {
                
                NavigationStack {
                    CreateItemView(item: Item()) // new item

                }
            }
        }
    }
    
    
    
}

#Preview {
    ListView()
        .modelContainer(previewContainer)

}
