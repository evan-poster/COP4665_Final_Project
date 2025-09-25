//
//  bid.swift
//  W3DemoPt2
//
//  Created by Joseph Bender on 9/19/25.
//

import SwiftUI
import SwiftData

@Model
class Bid {
    @Attribute(.unique) var id: UUID
    var amount: Double
    var createdAt: Date

//    @Relationship(inverse: \User.bids) var bidder: User?
//    @Relationship(inverse: \Car.bids) var car: Car?

    init(bidder: User?, car: Car?, amount: Double) {
        self.id = UUID()
        self.amount = amount
        self.createdAt = Date()
//        self.bidder = bidder
//        self.car = car
    }
}
