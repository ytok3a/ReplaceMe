//
//  ContentView.swift
//  ReplaceMe
//
//  Created by Cesar Fuentes on 9/2/23.
//

import SwiftUI

struct ListView: View {
    @StateObject var viewModel = ListViewViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                
            }
            .navigationTitle("Your Items")
            .toolbar {
                Button {
                    viewModel.showingCreateItemView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showingCreateItemView) {
                CreateItemView(newItemPresented: $viewModel.showingCreateItemView)
            }
        }
    }
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
