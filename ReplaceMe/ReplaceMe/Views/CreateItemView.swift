//
//  CreateItemView.swift
//  ReplaceMe
//
//  Created by Cesar Fuentes on 9/2/23.
//

import SwiftUI

struct CreateItemView: View {
    
    @StateObject var viewModel = CreateItemViewViewModel()
    @Binding var newItemPresented: Bool

    // TODO: if clicked anywhere else it should close too
    // TODO: make gramatically correct
    // TODO: Validate if reminding before replacement
    // TODO: add years everywhere

    let presets = ["None", "🧯 Fire Extinguisher", "💧 Water Filter", "👁 Contact Lens Case", "🪥 Toothbrush", "🧽 Sponges", "🛌 Pillows", "🏠 Air Filter", "🔋 Smoke Alarm Batteries"]

    
    var body: some View {
        NavigationView {

            VStack {
                
                
                TextField("", text: $viewModel.icon)
                    .font(.system(size: 64))
                    .padding(10)
                    .background(.gray)
                    .clipShape(Circle())
                    .multilineTextAlignment(.center)
                    .onChange(of: viewModel.icon) { _ in
                        viewModel.icon = String(viewModel.icon.prefix(1))
                    }
                
                
                Form {
                    

                    
                                        
                    Section {
                        
                        TextField("Name", text: $viewModel.name)
                            .textFieldStyle(DefaultTextFieldStyle())
                        
                        
                        // MARK: Last Replaced ///////////////////////////////////////////////////////////////////////////////////////////////////////
                        DatePicker("Last Replaced", selection: $viewModel.lastReplaced, displayedComponents: .date)
                            .datePickerStyle(.compact)
                                       
                        // MARK: Replace Every //////////////////////////////////////////////////////////////////////////////////////////////////////
                        HStack {
                            Text("Replace Every")
                            Spacer()
                            Text("\(viewModel.replaceEvery.value) \(viewModel.replaceEvery.unit.rawValue)")
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation {
                                viewModel.isPickerVisible.toggle()
                            }
                        }
                        if viewModel.isPickerVisible {
                            DateDurationPicker(selection: $viewModel.replaceEvery, values: Array(1..<100), units: DateDuration.Unit.allCases)
                        }

                        
                        // MARK: Remind Me ///////////////////////////////////////////////////////////////////////////////////////////////////////////
                        HStack {
                            Text("Remind Me")
                            Spacer()
                            Text("\(viewModel.remindBefore.value) \(viewModel.remindBefore.unit.rawValue) before")
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation {
                                viewModel.isPicker2Visible.toggle()
                            }
                        }
                        if viewModel.isPicker2Visible {
                            DateDurationPicker(selection: $viewModel.remindBefore, values: Array(1..<100), units: DateDuration.Unit.allCases)
                        }

                    }
                    
                    
                    Section {


                        TextField("", text: $viewModel.notes)
                            .textFieldStyle(DefaultTextFieldStyle())


                    }header: {
                        Text("Notes")
                    }
                    
                    Section {
                                                
                        Picker("Presets", selection: $viewModel.preset) {
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
            
//            .navigationTitle("New Item")

            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if viewModel.canSave {
                            viewModel.save()
                            newItemPresented = false
                        } else {
                            viewModel.showAlert = true
                        }
                        
                        
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", role: .cancel) {
                        
                    }
                }
                
            }
            
        }
        .scrollDismissesKeyboard(.interactively)
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Error"), message: Text("Please make sure to fill in all fields, select a replaced date that is before or on today, and set a reminder that happens before replacement."))
        }


    }
    

    
}

struct CreateItemView_Previews: PreviewProvider {
    static var previews: some View {
        CreateItemView(newItemPresented: Binding(get: {
            return true
        }, set: {_ in
            
        }))
    }
}
