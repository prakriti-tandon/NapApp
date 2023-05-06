//
//  Location.swift
//  hack_challenge
//
//  Created by Angela YUAN on 2023/4/29.
//

import Foundation

struct Location: Codable {
    
//    var imageName: String
//    var description: String
//    var campus: String
//    var brightness: String
//    var noise: String
//    var selected: Bool
//    var availability: Bool
    var id: Int
    var building: String
    var room: String
    var occupied: Bool
    var dark: Bool
    var quiet: Bool
    var region: String
    var occupier_id: Int
//    var imageName = "image1"

//    init(imageName: String = "image1", description: String, campus: String, brightness: String, noise: String, availability: Bool = true) {
//        self.imageName = imageName
//        self.description = description
//        self.campus = campus
//        self.brightness = brightness
//        self.noise = noise
//        self.selected = false
//        self.availability = availability
//    }
    
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
