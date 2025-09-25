//
//  CarView.swift
//  W3DemoPt2
//
//  Created by Joseph Bender on 9/18/25.
//


import SwiftUI
import SwiftData

class CarVM: ObservableObject, Identifiable {
    @Environment(\.modelContext) var ctx: ModelContext
    @Published var car: Car
    
    init(car: Car) {
        self.car = car
    }
    
    static func fromJSON(dto: CarDTO) -> CarVM {
        let dto_url = dto.url ?? "generic_car"
        let car = Car(
            brand: dto.brand,
            model: dto.model,
            year: dto.year,
            price: dto.price,
            miles: 50000,
            owner: User.preview
        )
        car.carURL = dto_url
        let carVM = CarVM(car: car)
        return carVM
    }
    
    func updatePrice(email: String) {
//        self..email = email
//        } else {
//            print("CRITICAL: Failed to find user")
//        }
//
        do {
            try ctx.save()
        } catch {
            print("Failed to update email")
        }
//        session.ctx.update(User.self, email)
    }
}
