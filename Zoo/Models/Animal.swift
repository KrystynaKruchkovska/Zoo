//
//  Animal.swift
//  Zoo
//
//  Created by Paweł on 30/09/2022.
//

import Foundation

struct Animal: Codable {
    let name, latinName: String
    let animalType: AnimalType
    let activeTime: ActiveTime
    let lengthMin, lengthMax, weightMin, weightMax: String
    let lifespan, habitat, diet, geoRange: String
    let imageLink: String
    let id: Int

    enum CodingKeys: String, CodingKey {
        case name
        case latinName = "latin_name"
        case animalType = "animal_type"
        case activeTime = "active_time"
        case lengthMin = "length_min"
        case lengthMax = "length_max"
        case weightMin = "weight_min"
        case weightMax = "weight_max"
        case lifespan, habitat, diet
        case geoRange = "geo_range"
        case imageLink = "image_link"
        case id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.latinName = try container.decode(String.self, forKey: .latinName)
        self.lengthMin = try container.decode(String.self, forKey: .lengthMin)
        self.lengthMax = try container.decode(String.self, forKey: .lengthMax)
        self.weightMin = try container.decode(String.self, forKey: .weightMin)
        self.weightMax = try container.decode(String.self, forKey: .weightMax)
        self.lifespan = try container.decode(String.self, forKey: .lifespan)
        self.habitat = try container.decode(String.self, forKey: .habitat)
        self.diet = try container.decode(String.self, forKey: .diet)
        self.geoRange = try container.decode(String.self, forKey: .geoRange)
        self.imageLink = try container.decode(String.self, forKey: .imageLink)
        self.id = try container.decode(Int.self, forKey: .id)
        self.animalType = try container.decode(AnimalType.self, forKey: .animalType)
        self.activeTime = try container.decode(ActiveTime.self, forKey: .activeTime)
    }
}

enum ActiveTime: String, Codable {
    case diurnal = "Diurnal"
    case nocturnal = "Nocturnal"
    case other
    
    init(from decoder: Decoder) throws {
      let label = try decoder.singleValueContainer().decode(String.self)
        self = ActiveTime(rawValue: label) ?? ActiveTime.other
    }
}

enum AnimalType: String, Codable {
    case bird = "Bird"
    case mammal = "Mammal"
    case reptile = "Reptile"
    case other
    
    init(from decoder: Decoder) throws {
      let label = try decoder.singleValueContainer().decode(String.self)
        self = AnimalType(rawValue: label) ?? AnimalType.other
    }
}

typealias Animals = [Animal]
