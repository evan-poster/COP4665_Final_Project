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
