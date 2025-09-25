//
//  SplashView.swift
//  W3DemoPt2
//
//  Created by Joseph Bender on 9/18/25.
//

import SwiftUI

struct SplashView: View {
    @State private var scale: CGFloat = 0.8
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            RootView() // Replace with your main app view
        } else {
            ThemedBackground {
                    VStack {
                        // 🔹 Replace "AppLogo" with your asset name
                        Image(systemName: "car.fill") // temporary placeholder
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .foregroundStyle(.white)
                            .scaleEffect(scale)
                            .onAppear {
                                withAnimation(
                                    .easeInOut(duration: 1.0)
                                    .repeatForever(autoreverses: true)
                                ) {
                                    scale = 1.2
                                }
                            }
                        
                        Text("Shiftly")
                            .font(.largeTitle)
                            .bold()
                            .foregroundStyle(.white)
                            .padding(.top, 20)
                    }
                    .onAppear {
                        // ⏳ Stay on splash for 2.5s
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            withAnimation {
                                isActive = true
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    SplashView()
        .environmentObject(Session.preview)
}
