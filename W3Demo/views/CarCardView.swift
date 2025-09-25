//
//  CarCardView.swift
//  W3DemoPt2
//
//  Created by Joseph Bender on 9/18/25.
//

import SwiftUI

struct CarCard: View {
    let carVM: CarVM
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 12) {
                
                // Top Image with Badge + Price
                ZStack(alignment: .topLeading) {
                    Color.gray.opacity(0.4)
                    Image(systemName: "car.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 250)
                        .clipped()
                    //.cornerRadius(16, corners: [.topLeft, .topRight])
                    
                    //                if car.certified {
                    Text("CERTIFIED")
                        .font(.caption.bold())
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(6)
                        .padding(8)
                    //                }
                    
                    HStack {
                        Spacer()
                        Text("19.99")
                            .font(.headline.bold())
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(12)
                            .padding(8)
                    }
                }
                
                // Car Info
                VStack(alignment: .leading, spacing: 4) {
                    Text(carVM.car.brand)
                        .font(.headline)
                    Text(carVM.car.model)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    HStack(spacing: 16) {
                        Label("\(carVM.car.year)", systemImage: "gauge")
                        Label("\(carVM.car.fuelType)", systemImage: "fuelpump")
                        Label("\(carVM.car.year)", systemImage: "paintpalette")
                        Label("\(carVM.car.year)", systemImage: "gearshape")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }.padding(9)
                
                // Features (chips)
                HStack {
                    //                ForEach(car.fuelType.prefix(3), id: \.self) { feature in
                    //                    Text(feature)
                    //                        .font(.caption)
                    //                        .padding(.horizontal, 8)
                    //                        .padding(.vertical, 4)
                    //                        .background(Color.gray.opacity(0.1))
                    //                        .cornerRadius(6)
                    //                }
                    
                    //                if car.fuelType.count > 3 {
                    //                    Text("+\(car.fuelType.count - 3) more")
                    //                        .font(.caption)
                    //                        .foregroundColor(.secondary)
                    //                        .padding(.horizontal, 8)
                    //                        .padding(.vertical, 4)
                    //                        .background(Color.gray.opacity(0.1))
                    //                        .cornerRadius(6)
                    //                }
                }
                
                // CTA
                NavigationLink(destination: CarDetailsView(carVM: carVM)) {
                    Text("View Details")
                        .font(.callout.bold())
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(colors: [.cyan, .blue], startPoint: .leading, endPoint: .trailing)
                        )
                        .foregroundColor(.white)
                        .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
                }
            }
            .background(Color.white)
            .cornerRadius(16)
            .shadow(radius: 4, y: 2)
            .padding(.horizontal)
        }
    }
}

#Preview {
    let user = User(
        fname: "John",
        lname: "Doe",
        username: "user1",
        email: "user@example.com",
        digest: "akl23jrlkhj2efd82"
    )
    
    NavigationStack {
        ThemedBackground {
            ScrollView {
                CarCard(carVM: CarVM(car: Car(
                    brand: "Ford",
                    model: "Fiesta",
                    year: 1948,
                    price: 1999.99,
                    miles: 10000,
                    owner: user)
                ))
                CarCard(carVM: CarVM(car: Car(
                    brand: "Ford",
                    model: "Fiesta",
                    year: 1948,
                    price: 1999.99,
                    miles: 100000,
                    owner: user)
                ))
                CarCard(carVM: CarVM(car: Car(
                    brand: "Ford",
                    model: "Fiesta",
                    year: 1948,
                    price: 1999.99,
                    miles: 34000,
                    owner: user)
                ))
            }
        }
    }
}
