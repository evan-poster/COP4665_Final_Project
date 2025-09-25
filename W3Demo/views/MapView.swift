//
//  MapView.swift
//  W3DemoPt2
//
//  Created by Joseph Bender on 9/18/25.
//

import SwiftUI
import UIKit
import MapKit

struct MapUIView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.setRegion(region, animated: true)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    @objc class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapUIView
        init(_ parent: MapUIView) { self.parent = parent }
    }
}

//28.0249° N, 82.5294° W
struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 28.0249, longitude: -82.5294),
        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
    )
    
    var body: some View {
        MapUIView(region: $region)
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    MapView()
}
