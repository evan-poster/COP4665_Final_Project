//
//  ConversationsView.swift
//  W3Demo
//
//  Created by Assistant on 9/25/25.
//

import SwiftUI
import SwiftData

struct ConversationsView: View {
    @Query var conversations: [Conversation]
    @Environment(\.theme) var brand
    
    var body: some View {
        ThemedBackground {
            NavigationStack {
                if conversations.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "message.circle")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        Text("No conversations yet")
                            .font(.title2)
                            .foregroundColor(.gray)
                        Text("Start messaging sellers about cars you're interested in!")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List(conversations) { conversation in
                        NavigationLink(destination: ChatView(conversation: conversation)) {
                            ConversationRow(conversation: conversation)
                        }
                        .listRowBackground(Color.clear)
                    }
                    .listStyle(PlainListStyle())
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle("Messages")
        }
    }
}

struct ConversationRow: View {
    let conversation: Conversation
    
    var body: some View {
        HStack(spacing: 12) {
            // Avatar placeholder
            Circle()
                .fill(Color.blue.opacity(0.2))
                .frame(width: 50, height: 50)
                .overlay(
                    Text(String(conversation.otherUserName.prefix(1)))
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                )
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(conversation.otherUserName)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Spacer()
                    Text(conversation.timeAgo)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Text(conversation.carTitle)
                    .font(.subheadline)
                    .foregroundColor(.blue)
                    .lineLimit(1)
                
                Text(conversation.lastMessage)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    ConversationsView()
        .environment(\.theme, .sunset)
}