//
//  theme.swift
//  W3Demo
//
//  Created by Joseph Bender on 9/15/25.
//

import SwiftUI

extension Color {
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

        let r, g, b, a: Double
        switch hexSanitized.count {
        case 6: // RGB (no alpha)
            r = Double((rgb & 0xFF0000) >> 16) / 255
            g = Double((rgb & 0x00FF00) >> 8) / 255
            b = Double(rgb & 0x0000FF) / 255
            a = 1.0
        case 8: // RGBA
            r = Double((rgb & 0xFF000000) >> 24) / 255
            g = Double((rgb & 0x00FF0000) >> 16) / 255
            b = Double((rgb & 0x0000FF00) >> 8) / 255
            a = Double(rgb & 0x000000FF) / 255
        default:
            return nil
        }

        self.init(.sRGB, red: r, green: g, blue: b, opacity: a)
    }
    
    init(hex: String, default defaultColor: Color = .gray) {
        if let color = Color(hex: hex) {  // calls the failable one above
            self = color
        } else {
            self = defaultColor
        }
    }}

struct Theme: Equatable {
    struct Palette: Equatable {
        let primary: Color
        let secondary: Color
        let onPrimary: Color
        let cardBackground: Color
        let danger: Color
        let textField: Color
    }
    struct FormTheme: Equatable {
        let fieldColor: Color
        let fieldCorner: CGFloat
        let fieldText: Color
        let fieldPlaceholder: Color
    }
    struct Spacing: Equatable { let xs: CGFloat; let sm: CGFloat; let md: CGFloat; let lg: CGFloat }
    struct Radii: Equatable   { let sm: CGFloat; let md: CGFloat; let lg: CGFloat }
    struct Elevation: Equatable { let cardShadow: CGFloat }

    let palette: Palette
    let spacing: Spacing
    let radii: Radii
    let elevation: Elevation
    let form: FormTheme

    // Example variants (colors should exist in Assets with Any/Dark)
    static let brand = Theme(
        palette: .init(
            primary: Color("brand"),
            secondary: Color("brandSecondary"),
            onPrimary: .white,
            cardBackground: Color(.secondarySystemBackground),
            danger: .red,
            textField: Color("inputBrand")
        ),
        spacing: .init(xs: 4, sm: 8, md: 12, lg: 16),
        radii: .init(sm: 8, md: 12, lg: 20),
        elevation: .init(cardShadow: 6),
        form: .init(
            fieldColor: Color(hex: "#eeffff"),
            fieldCorner: 12,
            fieldText: .black,
            fieldPlaceholder: .gray
        )
    )

    static let sunset = Theme(
        palette: .init(
            primary: Color("sunset"),
            secondary: Color("sunsetSecondary"),
            onPrimary: .white,
            cardBackground: Color(.secondarySystemBackground),
            danger: .orange,
            textField: Color("inputSunset")
        ),
        spacing: .init(xs: 4, sm: 10, md: 14, lg: 18),
        radii: .init(sm: 10, md: 14, lg: 24),
        elevation: .init(cardShadow: 8),
        form: .init(
            fieldColor: Color(hex: "#ffaaaa"),
            fieldCorner: 12,
            fieldText: .white,
            fieldPlaceholder: .gray
        )
    )
}
