//
//  ContentView.swift
//  CatchThemAll
//
//  Created by Lori Rothermel on 9/12/24.
//

import SwiftUI

struct CreaturesListView: View {
    
    var creatures = ["Pikachu", "Squirtle", "Charzard", "Snorlax"]
    
    
    var body: some View {
        NavigationStack {
           
            List(creatures, id: \.self) { creature in
                Text(creature)
                    .font(.title2)
            }  // List
            .listStyle(.plain)
            .padding()
            .navigationTitle("Pokemon")
            
        }  // NavigationStack
        
    }  // some View
}  // ContentView

#Preview {
    CreaturesListView()
}
