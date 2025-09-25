//
//  message.swift
//  W3Demo
//
//  Created by Assistant on 9/25/25.
//

import SwiftData
import SwiftUI

@Model
class Message {
    @Attribute(.unique) var id: UUID = UUID()
    var content: String
    var sentAt: Date = Date()
    var isFromCurrentUser: Bool
    
    @Relationship(inverse: \Conversation.messages) var conversation: Conversation?
    
    init(content: String, isFromCurrentUser: Bool) {
        self.content = content
        self.isFromCurrentUser = isFromCurrentUser
    }
}