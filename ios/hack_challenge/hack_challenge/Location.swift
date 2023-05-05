//
//  Location.swift
//  hack_challenge
//
//  Created by Angela YUAN on 2023/4/29.
//

import Foundation

class Location {
    
    var imageName: String
    var description: String
    var campus: String
    var brightness: String
    var noise: String
    var selected: Bool
    
    init(imageName: String, description: String, campus: String, brightness: String, noise: String) {
        self.imageName = imageName
        self.description = description
        self.campus = campus
        self.brightness = brightness
        self.noise = noise
        self.selected = false
    }
    
    
}
