//
//  CreatureDetailViewModel.swift
//  CatchThemAll
//
//  Created by Lori Rothermel on 9/12/24.
//

import Foundation


@MainActor
class CreatureDetailViewModel: ObservableObject {
    
    @Published var height = 0.0
    @Published var weight = 0.0
    @Published var imageURL = ""
    var urlString = ""
    
    
    private struct Returned: Codable {
        var height: Double
        var weight: Double
        var sprites: Sprite
    }  // struct Returned

    struct Sprite: Codable {
        var front_default: String
    }  // struct Sprite
     
    
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
            self.height = returned.height
            self.weight = returned.weight
            self.imageURL = returned.sprites.front_default
        } catch {
            print("👹 ERROR: Could not use URL at \(urlString) to get data and response.")
        }  // do catch
        
    }  // func GetData
    
}  // CreaturesViewModel
