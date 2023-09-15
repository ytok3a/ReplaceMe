//
//  ContentView.swift
//  ReplaceMe
//
//  Created by Cesar Fuentes on 9/2/23.
//

import SwiftUI
import SwiftData



func updateBadge(items: [Item]) -> Void {
    
    // TODO: maybe this needs to be a callback function for async like above function??
    
    print("updating badge...")

    var count = 0
    for item in items {
        print("\(item.name) is overdue? \(item.isOverdue())")

        if (item.isOverdue() == true) {
            count += 1
        }
    }
    
    print(count)
    
    let content = UNMutableNotificationContent()
    content.badge = NSNumber(integerLiteral: count)

}

struct ListView: View {
    
    
    
    @State private var sheetIsPresented = false

    @Query var items: [Item]
    @Environment(\.modelContext) var modelContext
    
    init() {
        requestAuthorization()
        updateBadge(items: items)
        // TODO: maybe initialize vars before body
    }
    

    
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

