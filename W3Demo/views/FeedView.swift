//
//  FeedView.swift
//  W3DemoPt2
//
//  Created by Joseph Bender on 9/18/25.
//

import SwiftUI
import SwiftData

class CarCollection: ObservableObject {
    @Published var carVMs: [CarVM] = []
    @Query var cars: [Car]
    
    init() {
        let loader = JSONLoader()
        do {
//            let carDTOs = try loader.load([CarDTO].self, path: "cars.json")
//            for car in carDTOs {
//                carVMs.append(CarVM.fromJSON(dto: car))
//            }
            
        } catch {
            print("Error loading json")
        }
        for car in cars {
            carVMs.append(CarVM(car: car))
        }
    }
    
    func fromCloud() async {
        let api = CarAPI()
        do {
            let void = try await api.fetchCloudJSON()
            var cars = try api.toCarModel()
            for car in cars {
                carVMs.append(car)
            }
        } catch {
            print("ERROR")
        }
    }
}

struct FeedView: View {
    @StateObject private var collection: CarCollection

    init(collection: CarCollection = CarCollection()) {
        _collection = StateObject(wrappedValue: collection)
    }
    
    var body: some View {
        ThemedBackground {
            ScrollView {
                LazyVStack {
                    ForEach(collection.carVMs) { carVM in
                            CarCard(carVM: carVM)
                    }
                }
            }
        }
    }
    
    func hello() {
        print("Hello")
    }
}

class MockCarCollection: CarCollection {
    override init() {
        super.init()
        self.carVMs = [
            CarVM(car: Car(brand: "Tesla", model: "Model S", year: 2024, price: 79999, miles: 1000, owner: User.preview)),
            CarVM(car: Car(brand: "Ford", model: "Mustang", year: 2020, price: 39999, miles: 15000, owner: User.preview)),
            CarVM(car: Car(brand: "Ford", model: "Mustang", year: 2020, price: 39999, miles: 15000, owner: User.preview)),
            CarVM(car: Car(brand: "Ford", model: "Mustang", year: 2020, price: 39999, miles: 15000, owner: User.preview)),
            CarVM(car: Car(brand: "Ford", model: "Mustang", year: 2020, price: 39999, miles: 15000, owner: User.preview)),
            CarVM(car: Car(brand: "Ford", model: "Mustang", year: 2020, price: 39999, miles: 15000, owner: User.preview)),
            CarVM(car: Car(brand: "Ford", model: "Mustang", year: 2020, price: 39999, miles: 15000, owner: User.preview)),
            CarVM(car: Car(brand: "Ford", model: "Mustang", year: 2020, price: 39999, miles: 15000, owner: User.preview)),
            CarVM(car: Car(brand: "Ford", model: "Mustang", year: 2020, price: 39999, miles: 15000, owner: User.preview))
        ]
    }
}

#Preview {
    FeedView(collection: MockCarCollection())
        .environment(\.theme, .sunset)
}
