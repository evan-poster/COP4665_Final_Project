//
//  like.swift
//  W3DemoPt2
//
//  Created by Joseph Bender on 9/18/25.
//

import SwiftUI
import SwiftData

@Model
class Like {
    @Attribute(.unique) var id: UUID
    var createdAt: Date

    @Relationship(inverse: \User.likes) var user: User?
    @Relationship(inverse: \Car.likes) var car: Car?

    init(user: User?, car: Car?) {
        self.id = UUID()
        self.createdAt = Date()
        self.user = user
        self.car = car
    }
}
