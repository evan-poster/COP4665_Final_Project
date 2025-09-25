//
//  ChatView.swift
//  W3Demo
//
//  Created by Assistant on 9/25/25.
//

import SwiftUI
import SwiftData

struct ChatView: View {
    @ObservedObject var conversation: Conversation
    @State private var newMessage: String = ""
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        ThemedBackground {
            VStack(spacing: 0) {
                // Car context header
                CarContextHeader(conversation: conversation)
                
                // Messages
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 8) {
                            ForEach(conversation.messages.sorted(by: { $0.sentAt < $1.sentAt })) { message in
                                MessageBubble(message: message)
                                    .id(message.id)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 8)
                    }
                    .onAppear {
                        if let lastMessage = conversation.messages.last {
                            withAnimation(.easeOut(duration: 0.3)) {
                                proxy.scrollTo(lastMessage.id, anchor: UnitPoint.bottom)
                            }
                        }
                    }
                    .onChange(of: conversation.messages.count) { _, _ in
                        if let lastMessage = conversation.messages.last {
                            withAnimation(.easeOut(duration: 0.3)) {
                                proxy.scrollTo(lastMessage.id, anchor: UnitPoint.bottom)
                            }
                        }
                    }
                }
                
                // Message composer
                MessageComposer(
                    newMessage: $newMessage,
                    onSend: sendMessage
                )
            }
        }
        .navigationTitle(conversation.otherUserName)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func sendMessage() {
        guard !newMessage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        
        let message = Message(content: newMessage, isFromCurrentUser: true)
        message.conversation = conversation
        conversation.messages.append(message)
        conversation.lastMessage = newMessage
        conversation.lastMessageTime = Date()
        
        modelContext.insert(message)
        
        newMessage = ""
        
        // Simulate response after a delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            simulateResponse()
        }
    }
    
    private func simulateResponse() {
        let responses = [
            "Thanks for your interest!",
            "Yes, it's still available.",
            "I can meet this weekend.",
            "Let me check and get back to you.",
            "That sounds reasonable.",
            "The car is in excellent condition.",
            "I have all the maintenance records."
        ]
        
        let randomResponse = responses.randomElement() ?? "Thanks for your message!"
        let responseMessage = Message(content: randomResponse, isFromCurrentUser: false)
        responseMessage.conversation = conversation
        conversation.messages.append(responseMessage)
        conversation.lastMessage = randomResponse
        conversation.lastMessageTime = Date()
        
        modelContext.insert(responseMessage)
    }
    
}

struct CarContextHeader: View {
    let conversation: Conversation
    
    var body: some View {
        HStack {
            Image("default_car")
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading, spacing: 2) {
                Text(conversation.carTitle)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Text("Tap to view details")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .background(.thinMaterial)
        .overlay(
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(Color(.separator)),
            alignment: .bottom
        )
    }
}

struct MessageBubble: View {
    let message: Message
    
    var body: some View {
        HStack {
            if message.isFromCurrentUser {
                Spacer(minLength: 50)
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text(message.content)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                    
                    Text(formatTime(message.sentAt))
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            } else {
                VStack(alignment: .leading, spacing: 4) {
                    Text(message.content)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(Color(.systemGray5))
                        .foregroundColor(.primary)
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                    
                    Text(formatTime(message.sentAt))
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                
                Spacer(minLength: 50)
            }
        }
    }
    
    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct MessageComposer: View {
    @Binding var newMessage: String
    let onSend: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            TextField("Type a message...", text: $newMessage, axis: .vertical)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .lineLimit(1...4)
            
            Button(action: onSend) {
                Image(systemName: "arrow.up.circle.fill")
                    .font(.title2)
                    .foregroundColor(newMessage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? .gray : .blue)
            }
            .disabled(newMessage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
        .padding()
        .background(.thinMaterial)
    }
}

#Preview {
    let conversation = Conversation(
        carTitle: "2024 Tesla Model S",
        otherUserName: "John Smith",
        lastMessage: "Is this car still available?"
    )
    
    ChatView(conversation: conversation)
        .environment(\.theme, .sunset)
}