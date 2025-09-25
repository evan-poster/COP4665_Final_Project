//
//  user.swift
//  W3DemoPt2
//
//  Created by Joseph Bender on 9/18/25.
//

import SwiftData
import SwiftUI

@Model class User {
    @Attribute(.unique) var id: UUID = UUID()
    @Attribute(.unique) var username: String
    @Attribute(.unique) var email: String

    var fname: String
    var lname: String
    var avatarURL: String = "default_avatar"
    var digest: String
    var accountActivated: Bool = false
    var createdAt: Double = Date().timeIntervalSince1970
    var updatedAt: Double = Date().timeIntervalSince1970
    var lastLoginAt: Double = Date().timeIntervalSince1970

    var dob: Date?
    var gender: Int?
    
    @Relationship var buyOrders: [Order] = []
    @Relationship var sellOrders: [Order] = []
    @Relationship(inverse: \Car.owner) var cars: [Car] = []
    @Relationship(deleteRule: .cascade) var likes: [Like] = []
    
    func name() -> String {
        return "\(fname) \(lname)"
    }
    
    init(fname: String, lname: String, username: String, email: String, digest: String) {
        self.fname = fname
        self.lname = lname
        self.username = username
        self.email = email
        self.digest = digest
    }
}
