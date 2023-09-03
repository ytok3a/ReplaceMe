//
//  ReadItemView.swift
//  ReplaceMe
//
//  Created by Cesar Fuentes on 9/2/23.
//

import SwiftUI
import SwiftData

struct ReadItemView: View {
    
    // Parameters
    @State var item: Item
    
    @State private var showingAlert = false
    
    // TODO: add changes from create view here

    
    var body: some View {
            
        VStack {
            
            Text("\(item.icon)")
                .font(.system(size: 64))
                .padding(10)
                .background(Color.init(item.getColor()))
                .clipShape(Circle())
                .multilineTextAlignment(.center)
            
            Form {
                
                Section {
                    
                    HStack {
                        Text("\(item.name)")
                    }
                    
                    if (!item.notes.isEmpty) {
                        HStack {
                            Text("\(item.notes)")
                        }
                    }


                }
                
                Section {
                    
                    
                    HStack {
                        Text("Last Replaced")
                        Spacer()
                        Text("\(item.lastReplaced.getAsString())")
                    }

                    
                    HStack {
                        Text("Replace Every")
                        Spacer()
                        Text("\(item.replaceEvery.value) \(item.replaceEvery.unit.rawValue)")
                    }
                    
                    HStack {
                        Text("Remind Me")
                        Spacer()
                        Text("\(item.remindBefore.value) \(item.remindBefore.unit.rawValue) before")
                    }

                }

//                Section {
//                    
//                    TextField("", text: $item.notes)
//                        .textFieldStyle(DefaultTextFieldStyle())
//                        .disabled(true)
//                    
//                }header: {
//                    Text("Notes")
//                }
                
                Section {
                    
                    HStack {
                        Text("Replace On")
                        Spacer()
                        Text("\(item.getReplacementDate().getAsString())")
                    }
                    .disabled(true)
                    
                    HStack {
                        Text("Time Remaining")
                        Spacer()
                        Text("\(item.getRemainingTime())")
                    }
                    .disabled(true)

                    
                }
                
                Button("Replace Me", systemImage: "arrow.clockwise") {
                    showingAlert = true
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Replace This Item?"),
                          // message: Text("You can always "),
                          // TODO: add a message if they still have a few days left
                          primaryButton: .default(Text("OK")) {
                            item.lastReplaced = Date()
                          },
                          secondaryButton: .cancel() )
                }
                
            }

            
        }
        
        
                    
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit", role: .cancel) {
//                    dismiss()
                    // TODO: edit, remove .cancel
                }
            }
            
        }
    }

}


struct ReadItemHelper: View {
    
    @Query var items: [Item]
    var body: some View {
        if let item = items.first {
            ReadItemView(item: item)
        } else {
            Text("no date")
        }
    }
}
    

#Preview {
    NavigationStack {
        ReadItemHelper()
            .modelContainer(previewContainer)

    }
}
