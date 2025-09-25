//
//  styles.swift
//  W3Demo
//
//  Created by Joseph Bender on 9/15/25.
//

import SwiftUI

struct PillButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(Capsule().fill(configuration.isPressed ? .blue.opacity(0.7) : .blue))
            .foregroundStyle(.white)
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
    }
}

struct CardStyle: ViewModifier {
    @Environment(\.theme) private var theme
    @Environment(\.cornerRadius) private var radius

    func body(content: Content) -> some View {
        content
            .padding(48)
            .background(
                RoundedRectangle(cornerRadius: radius)
                    .fill(Color(.secondarySystemBackground))
            )
            .shadow(radius: theme == .sunset ? 12 : 6)
    }
}

extension View {
    func cardStyle() -> some View { modifier(CardStyle()) }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
