//
//  ProfileView.swift
//  W3DemoPt2
//
//  Created by Joseph Bender on 9/18/25.
//

import SwiftUI
import SwiftData

struct EditProfileView: View {
    @EnvironmentObject var session: Session
    @ObservedObject var uservm: UserVM
    
    var body: some View {
        ThemedBackground {
            VStack {
                StyledSection(title: "Email") {
                    TextField("email", text: $uservm.user.email).formFieldStyle()
                }
                Button(action: updateEmail) {
                    Text("Update")
                }.buttonStyle(PillButtonStyle())
            }.formStyle()
        }
    }
    
    func updateEmail() {
        uservm.updateEmail(email: uservm.user.email)
    }
}

struct ProfileView: View {
    @EnvironmentObject var session: Session
//    @Query(filter: #Predicate<User> { $0.email == "asmith@example.com" })
//    var user: User

    
    var body: some View {
        NavigationStack {
            ThemedBackground {
                VStack {
                    HStack {
                        Spacer()
                        NavigationLink(destination: EditProfileView(uservm: UserVM(user: session.currentUser!))) {
                            Image(systemName: "pencil")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .tint(.white)
                        }
                    }.padding([.horizontal], 20)
                    Image(session.currentUser!.avatarURL)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 300, height: 300)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(.blue, lineWidth: 6))
                        .padding(20)
                    ZStack {
                        Rectangle()
                            .fill(.white)
                            .ignoresSafeArea(edges: .all)
                        VStack(alignment: .leading) {
                            StyledSection(title: "Name") {
                                if let user = session.currentUser {
                                    Text(user.name())
                                } else {
                                    Text("No name")
                                }
                            }
                            Spacer()
                            StyledSection(title: "Email") {
                                Text(session.currentUser!.email)
                            }
                            Spacer()
                            StyledSection(title: "Cars Sold") {
                                Text(session.currentUser!.email)
                            }
                            Spacer()
                            StyledSection(title: "Rating") {
                                Text(session.currentUser!.email)
                            }
                            Spacer()
                            StyledSection(title: "City") {
                                Text(session.currentUser!.email)
                            }
                            Spacer()
                        }.padding(48)
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(Session.preview)
}

