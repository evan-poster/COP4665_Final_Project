//
//  order.swift
//  W3DemoPt2
//
//  Created by Joseph Bender on 9/18/25.
//

import SwiftUI
import SwiftData

enum OrderStatus: String, Codable {
    case pending, confirmed, delivered, cancelled
}

@Model
class Order {
    @Attribute(.unique) var id: UUID
    var createdAt: Date
    var updatedAt: Date
    var status: OrderStatus

    @Relationship(inverse: \User.buyOrders) var buyer: User?
    @Relationship(inverse: \User.sellOrders) var seller: User?
    @Relationship(inverse: \Car.orders) var car: Car?

    init(buyer: User, seller: User, car: Car, status: OrderStatus = .pending) {
        self.id = UUID()
        self.createdAt = Date()
        self.updatedAt = Date()
        self.status = status
        self.buyer = buyer
        self.seller = seller
        self.car = car
    }
}
