//
//  auth.swift
//  W3Demo
//
//  Created by Joseph Bender on 9/15/25.
//

import SwiftUI
import SwiftData

struct SignUpView: View {
    @EnvironmentObject var session: Session
    
    @State private var fname: String = ""
    @State private var lname: String = ""
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var passwordConfirmation: String = ""
    @State private var errorStr: String? = nil
    
    
    var body: some View {
        ThemedBackground {
            VStack {
                StyledSection(title: "Username") {
                    TextField("Enter username", text: $username)
                        .textInputAutocapitalization(.never)   // disables automatic capitalization
                        .formFieldStyle() }
                StyledSection(title: "First Name") {
                    TextField("First name", text: $fname).formFieldStyle() }
                StyledSection(title: "Last Name") {
                    TextField("Last Name", text: $lname).formFieldStyle() }
                StyledSection(title: "Email") {
                    TextField("Email", text: $email)
                        .textInputAutocapitalization(.never)   // disables automatic capitalization
                        .keyboardType(.emailAddress)
                        .formFieldStyle() }
                StyledSection(title: "Password") {
                    SecureField("Password", text: $password).formFieldStyle() }
                StyledSection(title: "Confirm Password") {
                    SecureField("Confirm Password", text: $passwordConfirmation).formFieldStyle() }
                if let errorStr {
                    Text(errorStr)
                        .foregroundColor(.red)
                }
                Button(action: signup) {
                    Text("SignUp")
                }.buttonStyle(PillButtonStyle())
            }.formStyle()
        }
    }
    
    func signup() {
        do {
            try session.signup(fname: fname, lname: lname, username: username, email: email, password: password)
        } catch {
            print("Failed to signup")
            errorStr = "Failed to signup"
        }
    }
}

struct LoginView: View {
    @EnvironmentObject var session: Session
    @Environment(\.cornerRadius) var cornerRadius
    @Environment(\.theme) var brand
    @Environment(\.modelContext) var ctx: ModelContext
    
    @State private var usernameOrEmail: String = ""
    @State private var password: String = ""
    @State private var error: String? = nil
    
    var body: some View {
        NavigationStack {
            ThemedBackground {
                    VStack {
                        StyledSection(title: "Username") {
                            TextField("Username or Email", text: $usernameOrEmail)
                                .textInputAutocapitalization(.never)
                                .formFieldStyle()
                        }
                        StyledSection(title: "Password") {
                            SecureField("Password", text: $password)
                                .textInputAutocapitalization(.never)
                                .formFieldStyle()
                        }
                        Button(action: { login(context: ctx) }) {
                            Text("Login")
                        }.buttonStyle(PillButtonStyle())
                        
                        NavigationLink(destination: SignUpView()) {
                            Text("Sign Up")
                        }
                        
                        if let error {
                            Text(error)
                                .foregroundColor(.red)
                        }
                        
                    }.padding()
            }
        }
    }
    
    func login(context: ModelContext) {
        do {
            let descriptor = FetchDescriptor<User>(
                predicate: #Predicate { $0.fname == "Alice" }
            )
            
            if let user = try context.fetch(descriptor).first {
                let actualPassword = user.digest
                if password == actualPassword {
                    session.login(emailOrUsername: usernameOrEmail, password: password)
                } else {
                    print("Incorrect password!")
                    error = "Incorrect Email or Password"
                }
            } else {
                print("User does not exist!")
            }
        } catch {
            print("Login query failed: \(error)")
        }
    }}

#Preview {
    LoginView()
        .environment(\.theme, .sunset)
}
