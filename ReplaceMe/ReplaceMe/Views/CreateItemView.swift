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

    
    var body: some View {
        NavigationView {

            VStack {
                
                Form {
                    
                    Section {
                        
                        Text("🧯")
                            .font(.largeTitle)
                            .padding(10)
                            .background(.red)
                            .clipShape(Circle())
                        
                        TextField("Name", text: $viewModel.name)
                            .textFieldStyle(DefaultTextFieldStyle())
                        
                    }

                                        
                    Section {
                        
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
                                                
                        TextField("Notes", text: $viewModel.notes)
                            .textFieldStyle(DefaultTextFieldStyle())

                    }
                    
                }
                
            }
            
            .navigationTitle("New Item")

            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        viewModel.save()
                        newItemPresented = false
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", role: .cancel) {
                        
                    }
                }
            }
            
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
