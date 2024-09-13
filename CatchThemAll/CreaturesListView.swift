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
            List(creaturesVM.creaturesArray, id: \.self) { creature in
                NavigationLink {
                    DetailView(creature: creature)
                } label: {
                    Text(creature.name.capitalized)
                        .font(.title2)
                }  // NavigatonLink
            }  // List
            .listStyle(.plain)
            .padding()
            .navigationTitle("Pokemon")
        }  // NavigationStack
        .task {
            await creaturesVM.getData()
        }  // .task

    }  // some View
}  // CreaturesListView

#Preview {
    CreaturesListView()
}
