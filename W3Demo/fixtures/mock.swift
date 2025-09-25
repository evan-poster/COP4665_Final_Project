//
//  mock.swift
//  W3DemoPt2
//
//  Created by Joseph Bender on 9/18/25.
//

import SwiftData

extension ModelContainer {
    static var preview: ModelContainer {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        return try! ModelContainer(for: User.self, configurations: config)
    }
}

extension User {
    static var preview: User = User(
        fname: "John", lname: "Doe", username: "example", email: "user@example.com", digest: "lk32jlk32jelk23je"
    )
    
    static var mockSeller1: User = User(
        fname: "Sarah", lname: "Johnson", username: "sarahj", email: "sarah.j@example.com", digest: "abc123"
    )
    
    static var mockSeller2: User = User(
        fname: "Mike", lname: "Chen", username: "mikechen", email: "mike.chen@example.com", digest: "def456"
    )
    
    static var mockSeller3: User = User(
        fname: "Emily", lname: "Rodriguez", username: "emilyrod", email: "emily.r@example.com", digest: "ghi789"
    )
    
    static var mockSeller4: User = User(
        fname: "David", lname: "Wilson", username: "davidw", email: "david.w@example.com", digest: "jkl012"
    )
    
    static var mockSeller5: User = User(
        fname: "Lisa", lname: "Thompson", username: "lisat", email: "lisa.t@example.com", digest: "mno345"
    )
}

class MockSession: Session {
    override init(container: ModelContainer) {
        super.init(container: container)
        self.currentUser = User.preview // or true if you want MainView directly
    }

    override func signup(fname: String, lname: String, username: String, email: String, password: String) throws {
        // no-op
    }

    override func login(emailOrUsername: String, password: String) {
        // no-op
        self.currentUser = User.preview
    }
}

extension Session {
    static var preview: Session {
        MockSession(container: ModelContainer.preview)
    }
}
