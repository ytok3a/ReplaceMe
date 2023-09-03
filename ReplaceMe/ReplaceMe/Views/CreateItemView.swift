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
    
    @Environment(\.dismiss) private var dismiss
    
    // Parameters
    @State var item: Item

    @Environment(\.modelContext) var modelContext

    
    // TODO: if clicked anywhere else it should close too
    // TODO: make gramatically correct
    // TODO: Validate if reminding before replacement
    // TODO: add years everywhere

    let presets = ["None", "🧯 Fire Extinguisher", "💧 Water Filter", "👁 Contact Lens Case", "🪥 Toothbrush", "🧽 Sponges", "🛌 Pillows", "🏠 Air Filter", "🔋 Smoke Alarm Batteries"]
//    let preset = "None"
    @State private var preset = "None"


    var body: some View {
            
        VStack {
            
            TextField("", text: $item.icon)
                .font(.system(size: 64))
                .padding(10)
                .background(.gray)
                .clipShape(Circle())
                .multilineTextAlignment(.center)
                .onChange(of: item.icon, { oldValue, newValue in
                    item.icon = String(item.icon.prefix(1))
                })
            
            Form {
                
                Section {

                    
                    TextField("Name", text: $item.name)
                    //                            .textFieldStyle(DefaultTextFieldStyle())
                    
                    
                    // MARK: Last Replaced ///////////////////////////////////////////////////////////////////////////////////////////////////////
                    DatePicker("Last Replaced", selection: $item.lastReplaced, displayedComponents: .date)
                        .datePickerStyle(.compact)
                    
                    // MARK: Replace Every //////////////////////////////////////////////////////////////////////////////////////////////////////
                    HStack {
                        Text("Replace Every")
                        Spacer()
                        Text("\(item.replaceEvery.value) \(item.replaceEvery.unit.rawValue)")
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation {
                            isPickerVisible.toggle()
                        }
                    }
                    if isPickerVisible {
                        DateDurationPicker(selection: $item.replaceEvery, values: Array(1..<100), units: DateDuration.Unit.allCases)
                    }
                    
                    
                    // MARK: Remind Me ///////////////////////////////////////////////////////////////////////////////////////////////////////////
                    HStack {
                        Text("Remind Me")
                        Spacer()
                        Text("\(item.remindBefore.value) \(item.remindBefore.unit.rawValue) before")
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation {
                            isPicker2Visible.toggle()
                        }
                    }
                    if isPicker2Visible {
                        DateDurationPicker(selection: $item.remindBefore, values: Array(1..<100), units: DateDuration.Unit.allCases)
                    }
                    
                }

                
                
                Section {
                    
                    
                    
                    TextField("", text: $item.notes)
                        .textFieldStyle(DefaultTextFieldStyle())
                    
                    
                }header: {
                    Text("Notes")
                }
//                
                Section {
                    
                    Picker("Presets", selection: $preset) {
                        ForEach(0 ..< presets.count, id: \.self) {
                            Text(self.presets[$0])
                        }
                    }
                    
                } header: {
                    Text("Optional")
                }
                
                // TODO: have preset autopopulate viewModel
                // TODO: remove preset selection in this when anything changed
                
            }

            
        }
                    
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    if item.canSave() {
                        dismiss()
                        modelContext.insert(item)
                        
                    } else {
//                            item.showAlert = true
                    }
                    
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
    //    CreateItemView(item: Item(name: "Fire Extinguisher", icon: "🧯"))
            .modelContainer(previewContainer)

    }
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



//        .scrollDismissesKeyboard(.interactively)
//        .alert(isPresented: $item.showAlert) {
//            Alert(title: Text("Error"), message: Text("Please make sure to fill in all fields, select a replaced date that is before or on today, and set a reminder that happens before replacement."))
//        }


//    }


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



