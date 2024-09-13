//
//  CreaturesListView.swift
//  CatchThemAll
//
//  Created by Lori Rothermel on 9/12/24.
//

import SwiftUI

struct CreaturesListView: View {
    @StateObject var creaturesVM = CreaturesViewModel()
    
    
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                List(0..<creaturesVM.creaturesArray.count, id: \.self) { index in
                    LazyVStack {
                        NavigationLink {
                            DetailView(creature: creaturesVM.creaturesArray[index])
                        } label: {
                            Text("\(index + 1)   \(creaturesVM.creaturesArray[index].name.capitalized)")
                                .font(.title2)
                        }  // NavigatonLink
                    }  // VStack
                    .onAppear {
                        if let lastCreature = creaturesVM.creaturesArray.last {
                            if creaturesVM.creaturesArray[index].name == lastCreature.name && creaturesVM.urlString.hasPrefix("http") {
                                Task {
                                    await creaturesVM.getData()
                                }  // Task
                            }  // if
                        }  // if let
                    }  // .onAppear
                }  // List
                .listStyle(.plain)
                .padding()
                .navigationTitle("Pokemon")
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Text("\(creaturesVM.creaturesArray.count) pf \(creaturesVM.count)")
                            .font(.headline)
                            .foregroundColor(.red)
                    }  // ToolbarItem
                }  // .toolbar
                
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
