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
        let schema = Schema([User.self, Car.self, Order.self, Bid.self, Message.self, Conversation.self])
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
        
        // Add sample conversations if none exist
        if try context.fetch(FetchDescriptor<Conversation>()).isEmpty {
            // Sample conversation 1
            let conversation1 = Conversation(
                carTitle: "2024 Tesla Model S",
                otherUserName: "Mike Johnson",
                lastMessage: "Yes, it's still available!"
            )
            
            let message1 = Message(content: "Hi! Is this Tesla still available?", isFromCurrentUser: true)
            let message2 = Message(content: "Yes, it's still available!", isFromCurrentUser: false)
            message1.conversation = conversation1
            message2.conversation = conversation1
            conversation1.messages = [message1, message2]
            
            // Sample conversation 2
            let conversation2 = Conversation(
                carTitle: "2020 Ford Mustang",
                otherUserName: "Sarah Wilson",
                lastMessage: "I can meet this weekend"
            )
            
            let message3 = Message(content: "Would you consider $35,000?", isFromCurrentUser: true)
            let message4 = Message(content: "I can meet this weekend", isFromCurrentUser: false)
            message3.conversation = conversation2
            message4.conversation = conversation2
            conversation2.messages = [message3, message4]
            
            // Sample conversation 3
            let conversation3 = Conversation(
                carTitle: "2023 BMW M3",
                otherUserName: "David Chen",
                lastMessage: "The car is in excellent condition"
            )
            
            let message5 = Message(content: "How many miles does it have?", isFromCurrentUser: true)
            let message6 = Message(content: "The car is in excellent condition", isFromCurrentUser: false)
            message5.conversation = conversation3
            message6.conversation = conversation3
            conversation3.messages = [message5, message6]
            
            context.insert(conversation1)
            context.insert(conversation2)
            context.insert(conversation3)
            context.insert(message1)
            context.insert(message2)
            context.insert(message3)
            context.insert(message4)
            context.insert(message5)
            context.insert(message6)
            
            try context.save()
        }
    }
}

#Preview {
    RootView()
        .modelContainer(for: [User.self, Car.self, Order.self, Bid.self, Message.self, Conversation.self], inMemory: true)
        .environmentObject(Session.preview)
}
