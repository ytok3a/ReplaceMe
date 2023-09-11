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
    @State private var sheetIsPresented = false

    
    // TODO: add changes from create view here

    
    var body: some View {
        
            
        VStack {
            
            Form {
                
                Section {
                    HStack {
                        Spacer()
                        
                        VStack {
                            Text("\(item.icon)")
                                .font(.system(size: 64))
                                .padding([.bottom], 10)
                                .multilineTextAlignment(.center)
                            
                            Text("\(item.name)")
                                .padding([.bottom], 0.01)

                            Button(action: {
                                showingAlert = true
                            }) {
                                Text("Replace Me")
                            }
                            
                        }
                        
                        Spacer()
                        
                    }
                }
                .listRowBackground(Color.clear)
                // TODO: shrink space above emoji

                
                Section {
                    
                    
                    HStack {
                        Text("Last Replaced")
                        Spacer()
                        Text("\(item.lastReplaced.getAsString())")
                            .foregroundColor(.gray)
                    }

                    
                    HStack {
                        Text("Replace Every")
                        Spacer()
                        Text("\(item.replaceEvery.asString())")
                            .foregroundColor(.gray)
                    }
                    
                    HStack {
                        Text("Remind Me")
                        Spacer()
                        Text("\(item.remindBefore.asString()) before")
                            .foregroundColor(.gray)
                    }

                } header: {
                    Text("Settings")
                } footer: {
                    
                    // TODO: add if statement, if type is PresetItem
                    Text("\(item.disclaimer) [Read more...](\(item.link))")

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
                            .foregroundColor(.gray)
                    }
                    .disabled(true)
                    
                    HStack {
                        Text("Time Remaining")
                        Spacer()
                        Text("\(item.getRemainingTimeAsString())")
                            .foregroundColor(.gray)
                    }
                    .disabled(true)

                    
                } header: {
                    Text("UPCOMING")
                }
                
                
//                Button("Replace Me", systemImage: "arrow.clockwise") {
//                    showingAlert = true
//                }
                
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Replace This Item?"),
                          // message: Text("You can always "),
                          // TODO: add a message if they still have a few days left
                          primaryButton: .default(Text("OK")) {
                            item.lastReplaced = Date()
                          },
                          secondaryButton: .cancel() )
                }
                
                
                if (!item.notes.isEmpty) {
                    Section {

                        HStack {
                            Text("\(item.notes)")
                        }
                        
                    } header: {
                        Text("Notes")
                    }
                }

                
            }

        }
        
//        .navigationBarTitle("\(item.name)")

        
//        .navigationBarHidden(true)
                    
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                                        
                    sheetIsPresented.toggle()

                    // TODO: edit, remove .cancel
                }
            }
            
        }
        
        .sheet(isPresented: $sheetIsPresented) {
            
            NavigationStack {
                CreateItemView(item: item) // existing item
            }
        }
        
        .navigationBarTitle(Text(""), displayMode: .inline)

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
