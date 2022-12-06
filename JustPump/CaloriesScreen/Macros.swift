//
//  Macros.swift
//  JustPump
//
//  Created by Edward Fetzer on 31.10.22.
//

import Foundation

struct Macros: Codable {
    
    var items: [Item]?
}

struct Item: Codable {
    var sugar_g: Double?
    var fiber_g: Double?
    var serving_size_g: Int
    var sodium_mg: Int
    var name: String
    var potassium_mg: Int
    var fat_saturated_g: Double
    var fat_total_g: Double
    var calories: Double
    var cholesterol_mg: Double
    var protein_g: Double
    var carbohydrates_total_g: Double
}
