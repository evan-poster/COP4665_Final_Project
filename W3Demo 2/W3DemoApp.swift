//
//  W2D3_SwiftDataLiveDemoApp.swift
//  W2D3_SwiftDataLiveDemo
//
//  Created by Frank Bender on 9/11/25.
//

import SwiftUI
import SwiftData

struct RootView: View {
    @EnvironmentObject var session: Session
    
    var body: some View {
        if let _ = session.currentUser {
            MainView()
        } else {
            LoginView()
        }
    }
}

@main
struct W3DemoApp: App {
    var container: ModelContainer

    init() {
        let schema = Schema([User.self, Car.self, Order.self, Bid.self])
        let configuration = ModelConfiguration(schema: schema)
        self.container = try! ModelContainer(for: schema, configurations: [configuration])

        // Seed demo data
        try? seedData(container: container)
    }

    var body: some Scene {
        WindowGroup {
            SplashView()
                .modelContainer(container) // provides ModelContext automatically
                .environmentObject(Session(container: container))
                .environment(\.cornerRadius, 48)
                .environment(\.theme, .brand)
        }
    }

    private func seedData(container: ModelContainer) throws {
        let context = ModelContext(container)

        if try context.fetch(FetchDescriptor<User>()).isEmpty {
            let user = User(fname: "Alice", lname: "Smith",
                            username: "asmith", email: "asmith@example.com", digest: "pw")
            context.insert(user)
            try context.save()
        }
    }
}

#Preview {
    RootView()
        .modelContainer(for: [User.self, Car.self, Order.self, Bid.self], inMemory: true)
        .environmentObject(Session.preview)
}
