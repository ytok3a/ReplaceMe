//
//  ContentView.swift
//  ReplaceMe
//
//  Created by Cesar Fuentes on 9/2/23.
//

import SwiftUI
import SwiftData

func requestAuthorization() -> Void {
    let center = UNUserNotificationCenter.current()
    
    center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
        
        if let error = error {
            // Handle the error here.
        }
        
        // Enable or disable features based on the authorization.
        print("accessGranted? \(granted)")
        return
    }
    
}

struct ListView: View {
    
    init() {
        requestAuthorization()
        // TODO: maybe initialize vars before body
    }
    
    @State private var sheetIsPresented = false

    @Query var items: [Item]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationView {
            VStack {
                
                List {
                    ForEach (items.sorted { $0.getReplacementDate() < $1.getReplacementDate()}) { item in
                        HStack {
                            
                            NavigationLink {
                                  ReadItemView(item: item)
                            } label: {
                                
                                HStack() {
                                    Text("\(item.icon)")

                                    VStack(alignment: .leading) {
                                        Text(item.name)
//                                            .fontWeight(.bold)
                                        Text(item.getRemainingTimeAsString())
                                            .font(.subheadline)
                                            .foregroundColor(item.isOverdue() ? .red : .gray)

                                    }
                                    .padding([.leading], 5)
                                    
                                    Spacer()
                                }
                                
                            }
                        }
                        .swipeActions {
                            Button("Delete", role: .destructive) {
                                modelContext.delete(item)
                            }
                        }
                    }
                }
                
                
            }
            .navigationTitle("Your Items")
            .toolbar {
                Button {
                    sheetIsPresented.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
                        
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

