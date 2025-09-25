//
//  conversation.swift
//  W3Demo
//
//  Created by Assistant on 9/25/25.
//

import SwiftData
import SwiftUI

@Model
class Conversation {
    @Attribute(.unique) var id: UUID = UUID()
    var carTitle: String
    var otherUserName: String
    var lastMessage: String
    var lastMessageTime: Date = Date()
    
    @Relationship(deleteRule: .cascade) var messages: [Message] = []
    
    init(carTitle: String, otherUserName: String, lastMessage: String) {
        self.carTitle = carTitle
        self.otherUserName = otherUserName
        self.lastMessage = lastMessage
    }
    
    var timeAgo: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: lastMessageTime, relativeTo: Date())
    }
}