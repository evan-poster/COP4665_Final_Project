//
//  dto.swift
//  W3Demo
//
//  Created by Joseph Bender on 9/15/25.
//

import SwiftUI

struct SpecsDTO: Codable {
    let engine: String
    let horsepower: Int
    let fuelType: String

    enum CodingKeys: String, CodingKey {
        case engine, horsepower
        case fuelType = "fuel_type"
    }
}

struct CarDTO: Codable, Identifiable {
    let id = UUID() // so we can use it in SwiftUI lists
    let brand: String
    let model: String
    let year: Int
    let price: Double
    let specs: SpecsDTO
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case brand, model, year, price, specs, url
    }
}
