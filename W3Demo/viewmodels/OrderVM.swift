//
//  OrderVM.swift
//  W3DemoPt2
//
//  Created by Joseph Bender on 9/19/25.
//

import SwiftUI

class OrderVM: ObservableObject, Identifiable {
    @Published var order: Order
    
    init(order: Order) {
        self.order = order
    }
}
