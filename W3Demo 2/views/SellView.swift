//
//  sell.swift
//  W3Demo
//
//  Created by Joseph Bender on 9/17/25.
//

import SwiftUI
import PhotosUI
import SwiftData

struct SellView: View {
    @State var brand: String = ""
    @State var model: String = ""
    @State var price: String = ""
    @State var year: String = ""
    @State var miles: String = ""
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State var carImage: UIImage?
    
    @Environment(\.modelContext) var ctx: ModelContext
    @EnvironmentObject var session: Session
    
    var body: some View {
        ThemedBackground {
            ScrollView {
                StyledSection(title: "Brand") {
                    TextField("ex: Tesla", text: $brand).formFieldStyle()
                }
                StyledSection(title: "Model") {
                    TextField("ex: Model S", text: $model).formFieldStyle()
                }
                StyledSection(title: "Year") {
                    TextField("ex: 2024", text: $year).formFieldStyle()
                }
                StyledSection(title: "Price") {
                    TextField("ex: 36000", text: $price).formFieldStyle()
                }
                StyledSection(title: "Miles") {
                    TextField("ex: 36000", text: $miles).formFieldStyle()
                }
                
                if let carImage {
                    Image(uiImage: carImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 250)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 250)
                        .overlay(Text("No photo yet").foregroundColor(.gray))
                        .cornerRadius(12)
                }
                
                PhotosPicker(
                    selection: $selectedItem,
                    matching: .images,
                    photoLibrary: .shared()
                ) {
                    Label("Take or Choose Photo", systemImage: "camera.fill")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .onChange(of: selectedItem) { _, newItem in
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self),
                           let uiImage = UIImage(data: data) {
                            carImage = uiImage
                        }
                    }
                }
                
                Button(action: sellCar) {
                    Text("Submit")
                }.buttonStyle(PillButtonStyle())
            }.formStyle()
        }
    }
    

    func sellCar() {
        // Convert types safely
        guard let yearInt = Int(year),
              let priceDouble = Double(price),
              let milesInt = Int(miles),
              let user = session.currentUser else {
            print("Invalid input or no logged in user")
            return
        }

        let car = Car(
            brand: brand,
            model: model,
            year: yearInt,
            price: priceDouble,
            miles: milesInt,
            owner: user
        )

        ctx.insert(car)

        do {
            try ctx.save()
            print("✅ Car saved successfully")
        } catch {
            print("❌ Failed to save car: \(error)")
        }
    }
}

#Preview {
    SellView()
}
