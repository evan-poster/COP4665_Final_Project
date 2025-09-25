//
//  CarDetailsView.swift
//  W3DemoPt2
//
//  Created by Joseph Bender on 9/20/25.
//

import SwiftUI

struct CarDetailsView: View {
    @ObservedObject var carVM: CarVM
    
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
                Text("\(carVM.car.price)")
                NavigationLink(destination: OrderView(carVM: carVM)) {
                    Text("Place Order")
                }.buttonStyle(PillButtonStyle())
                Spacer()
            }
        }
    }
}

#Preview {
    CarDetailsView(carVM: CarVM(car: Car(brand: "Ford", model: "Raptor", year: 2023, price: 49999.99, miles: 30000, owner: User.preview)))
}
