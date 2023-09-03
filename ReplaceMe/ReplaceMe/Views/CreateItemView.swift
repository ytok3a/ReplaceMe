//
//  CreateItemView.swift
//  ReplaceMe
//
//  Created by Cesar Fuentes on 9/2/23.
//

import SwiftUI
import SwiftData

struct CreateItemView: View {
    @State private var isPickerVisible = false
    @State private var isPicker2Visible = false
    @State private var showingAlert = false
    
    @Environment(\.dismiss) private var dismiss
    
    // Parameters
    @State var item: Item

    @Query var items: [Item] // for
    @Environment(\.modelContext) var modelContext

    // TODO: promt emoji keyboard
    // TODO: if clicked anywhere else it should close too
    // TODO: make gramatically correct
    // TODO: remove preset selection in this when anything changed

    @State private var preset_selection = 0


    var body: some View {
            
        VStack {
            
//            TextField("", text: $item.icon)
//                .font(.system(size: 64))
//                .padding(10)
//                .background(.gray)
//                .clipShape(Circle())
//                .multilineTextAlignment(.center)
//                .onChange(of: item.icon, { oldValue, newValue in
//                    // handle only 1 emoji at a time
//                    item.icon = String(item.icon.prefix(1))
//                })
            
            
            
            Form {

                
                
                Section {
                    
                    
                    TextField("", text: $item.icon)
                        .font(.system(size: 64))
                        .padding(10)
                        .background(.gray)
                        .clipShape(Circle())
                        .multilineTextAlignment(.center)
                        .onChange(of: item.icon, { oldValue, newValue in
                            // handle only 1 emoji at a time
                            item.icon = String(item.icon.prefix(1))
                        })
                    
                    
                }
                .listRowBackground(Color.clear)

                
                
                Section {
                    
                    TextField("Name", text: $item.name)

                    TextField("Notes", text: $item.notes,  axis: .vertical)
                        .lineLimit(1...5)

                    
                } header: {
                    Text("Details")
                }
                
                Section {
                    
                    
                    DatePicker("Last Replaced", selection: $item.lastReplaced, displayedComponents: .date)
                        .datePickerStyle(.compact)
                    
                    HStack {
                        Text("Replace Every")
                        Spacer()
                        Text("\(item.replaceEvery.asString())")

                    }
                    .onTapGesture {
                        withAnimation {
                            isPickerVisible.toggle()
                        }
                    }
                    if isPickerVisible {
                        DateDurationPicker(selection: $item.replaceEvery, values: Array(1..<100), units: DateDuration.Unit.allCases)
                    }
                    
                    HStack {
                        Text("Remind Me")
                        Spacer()
                        Text("\(item.remindBefore.asString()) before")

                        
                    }
                    .onTapGesture {
                        withAnimation {
                            isPicker2Visible.toggle()
                        }
                    }
                    if isPicker2Visible {
                        DateDurationPicker(selection: $item.remindBefore, values: Array(1..<100), units: DateDuration.Unit.allCases)
                    }
                    
                } header: {
                    Text("Settings")
                }


                Section {
                    
                    Picker("Presets", selection: $preset_selection) {
                        ForEach(0 ..< presets.count, id: \.self) {
                            Text("\(presets[$0].icon) \(presets[$0].name)").tag($0)
                                // .tag($0)
                        }
                    }
                    .onChange(of: preset_selection) { _, _ in
                        print("Hello \(preset_selection)")
                        print("This is \(presets[preset_selection])")
//                        if (preset_selection != 0) {
                            item = presets[preset_selection]
//                        }
                        
                    }
                    
                } header: {
                    Text("Optional")
                }
                
                
            }

            
        }
        
                    
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    if item.canSave(items: items) {
                        modelContext.insert(item)
                        dismiss()
                    } else {
                        showingAlert = true
                    }
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Error"), message: Text("Please make sure to fill in all fields, select a replaced date that is before or on today, and set a reminder that happens before replacement."))
                }

            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel", role: .cancel) {
                    dismiss()
                }
            }
            
        }
    }

    
}


struct CreateItemHelper: View {
    
    @Query var items: [Item]
    var body: some View {
        if let item = items.first {
            CreateItemView(item: item)
        } else {
            Text("no date")
        }
    }

    
}

#Preview {
    NavigationStack {
        CreateItemHelper()
            .modelContainer(previewContainer)

    }
}



//                    .onChange(of: preset_selection) { _, _ in
//                        print(preset_selection)
                        // TODO: get item id then item then populate curr item with new item (including none item 0)
//                    }


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



//        .scrollDismissesKeyboard(.interactively)


//    }


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



