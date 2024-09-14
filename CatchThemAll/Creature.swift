//
//  Creature.swift
//  CatchThemAll
//
//  Created by Lori Rothermel on 9/12/24.
//

import Foundation

struct Creature: Codable, Identifiable {
    let id = UUID().uuidString
    var name: String
    var url: String  // url for detail on Pokemon.
    
    enum CodingKeys: CodingKey {
        case name
        case url
    }  // enum CodingKeys
    
}  // struct Result
