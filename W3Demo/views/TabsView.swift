//
//  TabsView.swift
//  W3DemoPt2
//
//  Created by Joseph Bender on 9/18/25.
//

import SwiftUI

struct TabStyle: LabelStyle {
    @Environment(\.theme) var brand
    
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 50) { configuration.icon; configuration.title }
            .foregroundColor(brand.palette.onPrimary)
    }
}
struct MainView: View {
    @Environment(\.theme) var brand
    
    init() {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        ThemedBackground {
            TabView {
                NavigationStack { SearchView() }.tabItem { Label("Search", systemImage: "magnifyingglass").labelStyle(TabStyle()) }
                NavigationStack { MapView() }.tabItem { Label("Map", systemImage: "map") }
                NavigationStack { FeedView() }.tabItem { Label("Feed", systemImage: "house") }
                NavigationStack { ConversationsView() }.tabItem { Label("Messages", systemImage: "message") }
                NavigationStack { OrdersView() }.tabItem { Label("Orders", systemImage: "bag") }
                NavigationStack { ProfileView() }.tabItem { Label("Profile", systemImage: "person") }
            }
            .scrollContentBackground(.hidden)
        }
    }
}

#Preview {
    MainView()
        .environment(\.theme, .sunset)
        .environmentObject(Session.preview)
}
