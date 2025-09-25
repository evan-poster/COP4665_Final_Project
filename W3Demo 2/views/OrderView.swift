//
//  OrderView.swift
//  W3DemoPt2
//
//  Created by Joseph Bender on 9/20/25.
//

import SwiftUI

struct OrderView: View {
    @ObservedObject var carVM: CarVM
    @State private var orderPrice: String

    init(carVM: CarVM) {
        self.carVM = carVM
        // convert Double to String for TextField binding
        _orderPrice = State(initialValue: String(carVM.car.price))
    }

    var body: some View {
        VStack {
            Text("Confirm Purchase")
                .font(.headline)

            StyledSection(title: "Price") {
                TextField("Price", text: $orderPrice)
                    .keyboardType(.decimalPad)
            }

            Button(action: placeOrder) {
                Text("Place Order")
            }
            .buttonStyle(PillButtonStyle())
        }
        .formStyle()
    }

    private func placeOrder() {
        if let price = Double(orderPrice) {
            print("Placing order for \(carVM.car.brand) \(carVM.car.model) at $\(price)")
            // TODO: Insert order logic here
        } else {
            print("⚠️ Invalid price input: \(orderPrice)")
        }
    }
}

#Preview {
    OrderView(carVM: CarVM(car: Car(brand: "Ford", model: "Fiesta", year: 1999, price: 19999.99, miles: 160000, owner: User.preview)))
}
