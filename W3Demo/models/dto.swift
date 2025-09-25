// Import the SwiftUI framework, which provides the building blocks for UI development
import SwiftUI

// Import Foundation, which provides essential data types (URL, JSONDecoder, etc.)
import Foundation

// MARK: - Data Transfer Object for Specs

// SpecsDTO represents the specifications of a car, and conforms to Codable for JSON encoding/decoding
struct SpecsDTO: Codable {
    // The type of engine (e.g., "2.0L I4")
    let engine: String
    // The horsepower rating of the engine
    let horsepower: Int
    // The type of fuel (e.g., "Gasoline", "Diesel", "Electric")
    let fuelType: String

    // Define how JSON keys map to Swift properties
    // This is necessary when JSON keys don’t match Swift’s property naming conventions
    enum CodingKeys: String, CodingKey {
        case engine           // Maps JSON key "engine" → property engine
        case horsepower       // Maps JSON key "horsepower" → property horsepower
        case fuelType = "fuel_type" // Maps JSON key "fuel_type" → property fuelType
    }
}

// MARK: - Data Transfer Object for Cars

// CarDTO represents a car object coming from JSON.
// Conforms to Codable for decoding, and Identifiable so SwiftUI lists can use it directly.
struct CarDTO: Codable, Identifiable {
    // A unique identifier automatically generated for each CarDTO.
    // This allows CarDTOs to be used in SwiftUI ForEach/List.
    let id = UUID()
    
    // Brand of the car (e.g., "Toyota", "BMW")
    let brand: String
    // Model of the car (e.g., "Camry", "3 Series")
    let model: String
    // Model year of the car
    let year: Int
    // Price of the car in USD
    let price: Double
    // Nested object for engine specs (decoded via SpecsDTO)
    let specs: SpecsDTO
    // Optional image or resource URL for the car (may be nil if not available)
    let url: String?
    
    // Define how JSON keys map to Swift properties.
    // Here, keys match exactly, so this enum is technically optional,
    // but it's included for clarity and future safety if JSON changes.
    enum CodingKeys: String, CodingKey {
        case brand, model, year, price, specs, url
    }
}

enum ValidationError: Error {
    case valueOutOfRange(message: String)
}

// MARK: - API Layer

// CarAPI handles fetching car data from the cloud asynchronously.
class CarAPI {
    // The URL where your JSON file is hosted on Google Cloud Storage.
    // Force unwrapped (!) here because the string is hardcoded and known to be valid.
    private let url = URL(string: "https://storage.googleapis.com/cop4665/api_cars.json")!
    
    // An internal array to hold decoded CarDTOs (not currently exposed publicly).
    private var carDTOs: [CarDTO] = []
    
    // Async function that downloads JSON data from the cloud,
    // decodes it into CarDTO objects, and returns them.
    func fetchCloudJSON() async throws -> [CarDTO] {
        // Perform a network request to fetch raw data from the URL.
        // The `await` keyword suspends execution until data is returned.
        let (data, _) = try await URLSession.shared.data(from: url)
        
        // Decode the raw JSON data into an array of CarDTO objects using JSONDecoder.
        let cars = try JSONDecoder().decode([CarDTO].self, from: data)
        
        // Return the decoded array of cars to the caller.
        return cars
    }
    
    func toCarModel() throws -> [CarVM] {
        var carVMs: [CarVM] = []
        if self.carDTOs.isEmpty {
            ValidationError.valueOutOfRange(message: "JSON has not been loaded yet")
        } else {
            for dto in carDTOs {
                carVMs.append(CarVM.fromJSON(dto: dto))
            }
        }
        return carVMs
    }
}
