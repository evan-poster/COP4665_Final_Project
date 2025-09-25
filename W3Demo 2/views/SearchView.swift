//
//  SearchView.swift
//  W3DemoPt2
//
//  Created by Joseph Bender on 9/18/25.
//

import SwiftUI
import SwiftData

struct SearchBar: View {
    @Binding var text: String
    var placeholder: String = "Search..."
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField(placeholder, text: $text)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
            
            if !text.isEmpty {
                Button(action: { text = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(10)
        .background(.thinMaterial) // glass-like background
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        .padding(.horizontal)
    }
}

struct SearchView: View {
    @State private var query: String = ""
    @Query var users: [User]
    
    var body: some View {
        ThemedBackground {
            VStack {
                SearchBar(text: $query, placeholder: "Search cars...")
                
                ScrollView {
                    LazyVStack {
                        ForEach(sampleCars.filter {
                            query.isEmpty ? true :
                            $0.localizedCaseInsensitiveContains(query)
                        }, id: \.self) { car in
                            Text(car)
                        }
                    }.listStyle(PlainListStyle())
                    
                    LazyVStack {
                        ForEach(users, id: \.self) { user in
                            Text("\(user.fname) \(user.lname)")
                        }
                    }
                }
            }
            .navigationTitle("Search")
        }
    }
    
    let sampleCars = [
        "Tesla Model S",
        "Toyota Supra",
        "BMW M3",
        "Ford Mustang",
        "Audi A4"
    ]
}

#Preview {
    SearchView()
}
