//
//  UserVM.swift
//  W3DemoPt2
//
//  Created by Joseph Bender on 9/18/25.
//

import SwiftUI
import SwiftData

class UserVM: ObservableObject {
    @EnvironmentObject var session: Session
    @Environment(\.modelContext) var ctx: ModelContext
    @Published var user: User
    
    init(user: User) {
        self.user = user
    }
    
    func updateEmail(email: String) {
        self.user.email = email
//        } else {
//            print("CRITICAL: Failed to find user")
//        }
//        
        do {
            try ctx.save()
        } catch {
            print("Failed to update email")
        }
//        session.ctx.update(User.self, email)
    }
}
