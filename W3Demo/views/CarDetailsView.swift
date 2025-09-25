//
//  CarDetailsView.swift
//  W3DemoPt2
//
//  Created by Joseph Bender on 9/20/25.
//

import SwiftUI
import SwiftData

struct CarDetailsView: View {
    @ObservedObject var carVM: CarVM
    @Environment(\.modelContext) var modelContext
    @State private var showingChat = false
    
    var body: some View {
        ThemedBackground {
            VStack {
                Image(systemName: "car.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 250)
                    .clipped()
                VStack {
                    HStack {
                        Image("default_avatar")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(.blue, lineWidth: 4))
                        Text(carVM.car.owner!.name())
                    }
                }.padding()
                Text("$\(carVM.car.price, specifier: "%.0f")")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .padding()
                
                VStack(spacing: 12) {
                    Button(action: messageSellerTapped) {
                        HStack {
                            Image(systemName: "message")
                            Text("Message Seller")
                        }
                    }
                    .buttonStyle(SecondaryButtonStyle())
                    
                    NavigationLink(destination: OrderView(carVM: carVM)) {
                        Text("Place Order")
                    }.buttonStyle(PillButtonStyle())
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
        .navigationDestination(isPresented: $showingChat) {
            if let conversation = findOrCreateConversation() {
                ChatView(conversation: conversation)
            }
        }
    }
    
    private func messageSellerTapped() {
        showingChat = true
    }
    
    private func findOrCreateConversation() -> Conversation? {
        // Try to find existing conversation
        let descriptor = FetchDescriptor<Conversation>(
            predicate: #Predicate<Conversation> { conversation in
                conversation.carTitle == carVM.car.carName()
            }
        )
        
        if let existingConversation = try? modelContext.fetch(descriptor).first {
            return existingConversation
        }
        
        // Create new conversation
        let conversation = Conversation(
            carTitle: carVM.car.carName(),
            otherUserName: carVM.car.owner?.name() ?? "Seller",
            lastMessage: "Hi! I'm interested in your \(carVM.car.carName())"
        )
        
        // Add initial message
        let initialMessage = Message(
            content: "Hi! I'm interested in your \(carVM.car.carName()). Is it still available?",
            isFromCurrentUser: true
        )
        initialMessage.conversation = conversation
        conversation.messages.append(initialMessage)
        
        modelContext.insert(conversation)
        modelContext.insert(initialMessage)
        
        return conversation
    }
}

// Secondary button style for the message button
struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue.opacity(0.1))
            .foregroundColor(.blue)
            .cornerRadius(12)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

#Preview {
    CarDetailsView(carVM: CarVM(car: Car(brand: "Ford", model: "Raptor", year: 2023, price: 49999.99, miles: 30000, owner: User.preview)))
}
