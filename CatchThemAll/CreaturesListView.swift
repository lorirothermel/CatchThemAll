//
//  CreaturesListView.swift
//  CatchThemAll
//
//  Created by Lori Rothermel on 9/12/24.
//

import SwiftUI

struct CreaturesListView: View {
    @StateObject var creaturesVM = CreaturesViewModel()
    @State private var searchText = ""
    
    var searchResults: [Creature] {
        if searchText.isEmpty {
            return creaturesVM.creaturesArray
        } else {
            return creaturesVM.creaturesArray.filter {$0.name.capitalized.contains(searchText)}
        }  // if else
        
    }  // searchResults
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                List(searchResults) { creature in
                    LazyVStack {
                        NavigationLink {
                            DetailView(creature: creature)
                        } label: {
                            Text(creature.name.capitalized)
                                .font(.title2)
                        }  // NavigatonLink
                    }  // VStack
                    .onAppear {
                        Task {
                            await creaturesVM.loadNextIfNeeded(creature: creature)
                        }  // Task
                        
                    }  // .onAppear
                }  // List
                .listStyle(.plain)
                .padding()
                .navigationTitle("Pokemon")
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button("Load All") {
                            Task {
                                await creaturesVM.loadAll()
                            }  // Task
                        }  // Button
                        .buttonStyle(.borderedProminent)
                        
                    }  // ToolbarItem
                    
                    ToolbarItem(placement: .status) {
                        Text("\(creaturesVM.creaturesArray.count) pf \(creaturesVM.count) Creatures")
                            .font(.headline)
                            .foregroundColor(.red)
                    }  // ToolbarItem
                    
                }  // .toolbar
                .searchable(text: $searchText)
                
                if creaturesVM.isLoading {
                    ProgressView()
                        .tint(.red)
                        .scaleEffect(4)
                }  // if
                                       
                
            }  // ZStack

        }  // NavigationStack
        .task {
            await creaturesVM.getData()
        }  // .task
        
    }  // some View
}  // CreaturesListView

#Preview {
    CreaturesListView()
}
