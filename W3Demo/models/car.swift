//
//  car.swift
//  W3DemoPt2
//
//  Created by Joseph Bender on 9/18/25.
//

import SwiftData
import SwiftUI

@Model class Car {
    @Attribute(.unique) var id: UUID = UUID()
    var brand: String
    var model: String
    var year: Int
    var price: Double
    var carURL: String = "default_car"
    var fuelType: String?
    var engine: String?
    var horsepower: Int?
    var miles: Int
    var owner: User?
    
    @Relationship(deleteRule: .cascade) var likes: [Like]
    @Relationship(deleteRule: .nullify) var orders: [Order]
    
    init(brand: String, model: String, year: Int, price: Double, miles: Int, owner: User) {
        self.brand = brand
        self.model = model
        self.year = year
        self.price = price
        self.owner = owner
        self.likes = []
        self.orders = []
        self.miles = miles
    }
    
    func carName() -> String {
        return "\(brand) \(model) \(year)"
    }
}
