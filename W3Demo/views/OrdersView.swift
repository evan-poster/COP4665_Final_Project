//
//  OrdersView.swift
//  W3DemoPt2
//
//  Created by Joseph Bender on 9/18/25.
//

import SwiftUI

struct OrdersView: View {
    var orders: [OrderVM] = []
    
    var body: some View {
        NavigationStack {
            ThemedBackground {
                VStack {
                    NavigationLink(destination: SellView()) {
                        Text("Sell Car")
                    }.buttonStyle(PillButtonStyle())
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    OrdersView()
}
