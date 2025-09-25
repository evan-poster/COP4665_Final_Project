//
//  forms.swift
//  W3DemoPt2
//
//  Created by Joseph Bender on 9/18/25.
//

import SwiftUI

struct SectionHeaderStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.blue)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 8)
    }
}

struct FormFieldStyle: ViewModifier {
    @Environment(\.theme) var theme
    
    func body(content: Content) -> some View {
        content
            .textFieldStyle(.plain)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(theme.form.fieldColor)
//            .background(LinearGradient(colors: [theme.palette.primary, .green], startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(20)
            .foregroundColor(theme.form.fieldText) // typed text color
    }
}

struct StyledSection<Content: View>: View {
    let title: String
    @ViewBuilder let content: () -> Content

    var body: some View {
        Section(
            header: Text(title).sectionHeaderStyle()
        ) {
            content()
        }
    }
}

struct FormStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .textFieldStyle(.plain) // override Apple style
            .font(.body)
//            .tint(.purple) // accent color
    }
}

extension View {
    func formStyle() -> some View {
        self.modifier(FormStyle())
    }
    
    func formFieldStyle() -> some View {
        self.modifier(FormFieldStyle())
    }
    
    func sectionHeaderStyle() -> some View {
        self.modifier(SectionHeaderStyle())
    }
}

struct FormTemplateView: View {
    @State var name: String = ""
    
    var body: some View {
        ThemedBackground {
            VStack {
                StyledSection(title: "Name") {
                    TextField("Enter name", text: $name).formFieldStyle()
                }
                
                StyledSection(title: "Hello") {
                    TextField("Enter name", text: $name).formFieldStyle()
                }
                
                StyledSection(title: "Hello") {
                    TextField("Enter name", text: $name).formFieldStyle()
                }
                
                StyledSection(title: "Hello") {
                    TextField("Enter name", text: $name).formFieldStyle()
                }
                
                Button(action: something) {
                    Text("Submit")
                }.buttonStyle(PillButtonStyle())
            }.formStyle()
        }
    }
    
    func something() {
        print("ok")
    }
}

#Preview {
    FormTemplateView()
}
