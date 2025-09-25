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

    init(collection: CarCollection = MockCarCollection()) {
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
        
        // Create cars with fuel type data
        let tesla = Car(brand: "Tesla", model: "Model S", year: 2024, price: 79999, miles: 1200, owner: User.mockSeller1)
        tesla.fuelType = "Electric"
        
        let bmw = Car(brand: "BMW", model: "M3", year: 2023, price: 67500, miles: 8500, owner: User.mockSeller2)
        bmw.fuelType = "Gasoline"
        
        let mustang = Car(brand: "Ford", model: "Mustang GT", year: 2022, price: 45999, miles: 12000, owner: User.mockSeller3)
        mustang.fuelType = "Gasoline"
        
        let audi = Car(brand: "Audi", model: "A4", year: 2021, price: 38900, miles: 22000, owner: User.mockSeller4)
        audi.fuelType = "Gasoline"
        
        let mercedes = Car(brand: "Mercedes", model: "C-Class", year: 2023, price: 52000, miles: 5800, owner: User.mockSeller5)
        mercedes.fuelType = "Gasoline"
        
        let honda = Car(brand: "Honda", model: "Civic Type R", year: 2022, price: 42000, miles: 15500, owner: User.mockSeller1)
        honda.fuelType = "Gasoline"
        
        let toyota = Car(brand: "Toyota", model: "Camry", year: 2021, price: 28500, miles: 18000, owner: User.mockSeller2)
        toyota.fuelType = "Hybrid"
        
        let porsche = Car(brand: "Porsche", model: "911", year: 2020, price: 95000, miles: 25000, owner: User.mockSeller3)
        porsche.fuelType = "Gasoline"
        
        let corvette = Car(brand: "Chevrolet", model: "Corvette", year: 2023, price: 72000, miles: 3200, owner: User.mockSeller4)
        corvette.fuelType = "Gasoline"
        
        let lexus = Car(brand: "Lexus", model: "IS 350", year: 2022, price: 44500, miles: 11000, owner: User.mockSeller5)
        lexus.fuelType = "Gasoline"
        
        let nissan = Car(brand: "Nissan", model: "GT-R", year: 2021, price: 89000, miles: 7800, owner: User.mockSeller1)
        nissan.fuelType = "Gasoline"
        
        let subaru = Car(brand: "Subaru", model: "WRX STI", year: 2020, price: 35000, miles: 28000, owner: User.mockSeller2)
        subaru.fuelType = "Gasoline"
        
        self.carVMs = [
            CarVM(car: tesla),
            CarVM(car: bmw),
            CarVM(car: mustang),
            CarVM(car: audi),
            CarVM(car: mercedes),
            CarVM(car: honda),
            CarVM(car: toyota),
            CarVM(car: porsche),
            CarVM(car: corvette),
            CarVM(car: lexus),
            CarVM(car: nissan),
            CarVM(car: subaru)
        ]
    }
}

#Preview {
    FeedView(collection: MockCarCollection())
        .environment(\.theme, .sunset)
}
