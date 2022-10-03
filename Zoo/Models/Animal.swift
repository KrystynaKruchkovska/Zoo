//
//  Animal.swift
//  Zoo
//
//  Created by Paweł on 30/09/2022.
//

import Foundation

// MARK: - Animal
struct Animal: Codable {
    let name, latinName: String
//    let animalType: AnimalType
//    let activeTime: ActiveTime
    let lengthMin, lengthMax, weightMin, weightMax: String
    let lifespan, habitat, diet, geoRange: String
    let imageLink: String
    let id: Int

    enum CodingKeys: String, CodingKey {
        case name
        case latinName = "latin_name"
//        case animalType = "animal_type"
//        case activeTime = "active_time"
        case lengthMin = "length_min"
        case lengthMax = "length_max"
        case weightMin = "weight_min"
        case weightMax = "weight_max"
        case lifespan, habitat, diet
        case geoRange = "geo_range"
        case imageLink = "image_link"
        case id
        
    }
}

enum ActiveTime: String, Codable {
    case diurnal = "Diurnal"
    case nocturnal = "Nocturnal"
}

enum AnimalType: String, Codable {
    case bird = "Bird"
    case mammal = "Mammal"
    case reptile = "Reptile"
}

typealias Animals = [Animal]
