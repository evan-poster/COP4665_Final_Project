//
//  session.swift
//  W3Demo
//
//  Created by Joseph Bender on 9/15/25.
//

import SwiftUI
import SwiftData

class Session: ObservableObject {
    @Published var currentUser: User?
    private let container: ModelContainer
    private let ctx: ModelContext
    
    init(container: ModelContainer) {
        self.currentUser = nil
        self.container = container
        self.ctx = ModelContext(container)
    }
    
    func hash(password: String) -> String {
        return password
    }
    
    func signup(fname: String, lname: String, username: String, email: String, password: String) throws {
        let c = ctx
        let digest = hash(password: password)
        let user = User(fname: fname, lname: lname, username: username, email: email, digest: digest)
        
        c.insert(user)
        try c.save()
        currentUser = user
    }
    
    func login(emailOrUsername: String, password: String) {
        
        let digest = hash(password: password)
        if emailOrUsername == "USERNAME" && password == "PASSWORD" {
            currentUser = User.preview
        } else {
            print("Login Failed")
        }
        // @Query(User)
    }
}
