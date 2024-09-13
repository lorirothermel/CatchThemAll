//
//  CreaturesViewModel.swift
//  CatchThemAll
//
//  Created by Lori Rothermel on 9/12/24.
//

import Foundation


@MainActor
class CreaturesViewModel: ObservableObject {
    
    @Published var urlString = "https://pokeapi.co/api/v2/pokemon/"
    @Published var count = 0
    @Published var creaturesArray: [Creature] = []
    
    
    
    private struct Returned: Codable {
        var count: Int
        var next: String
        var results: [Creature]
    }  // struct Returned
    
    
    
    func getData() async {
        print("🕸️ We are accessing the url \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("👹 JSON ERROR: Could not decode returned JSON data!")
            return
        }  // guard let
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else {
                print("👹 JSON ERROR: Could not decode returned JSON data.")
                return
            }  // guard let
            self.count = returned.count
            self.urlString = returned.next
            self.creaturesArray = returned.results
        } catch {
            print("👹 ERROR: Could not use URL at \(urlString) to get data and response.")
        }  // do catch
        
    }  // func GetData
    
}  // CreaturesViewModel
