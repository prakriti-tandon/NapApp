//
//  Location.swift
//  hack_challenge
//
//  Created by Angela YUAN on 2023/4/29.
//

import Foundation

struct Location: Codable {
    
    var id: Int
    var building: String
    var room: String
    var occupied: Bool
    var dark: Bool
    var quiet: Bool
    var region: String
    var occupier_id: Int
    
    init(id: Int, building: String, room: String, occupied: Bool, dark: Bool, quiet: Bool, region: String, occupier_id: Int) {
        self.id = id
        self.building = building
        self.room = room
        self.occupied = occupied
        self.dark = dark
        self.quiet = quiet
        self.region = region
        self.occupier_id = occupier_id
    }
    
    
}

struct Locations: Codable {
    var locations: [Location]
}
