//
//  InformationView.swift
//  restaurant
//
//  Created by Ewa Solarska on 29/08/2023.
//

import SwiftUI
import MapKit

struct InformationView: View {
    @State private var latitude: Double = 52.229676
    @State private var longitude: Double = 21.012229
    @State private var pointName: String = "The Restaurant"
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 52.229676, longitude: 21.012229), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    @State private var zoomLevel: Double = 0.05
    
    let restaurantName = "The Restaurant"
    let address = "32-345 Warsaw, Street 34"
    let phoneNumber = "+48 111 111 111"
    let openingHours = "8:00 AM - 10:00 PM"
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text(restaurantName).font(.title)
                    Text("Address: \(address)")
                    Text("Phone: \(phoneNumber)")
                    Text("Opening hours: \(openingHours)")
                    Map(coordinateRegion: $region, annotationItems: [Place(name: pointName, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))]) { place in
                        MapAnnotation(coordinate: place.coordinate) {
                            AnnotationView(title: place.name)
                        }
                    }
                    .gesture(
                        TapGesture(count: 1)
                            .onEnded { _ in
                                if zoomLevel > 0.01 {
                                    zoomLevel -= 0.01
                                    region.span = MKCoordinateSpan(latitudeDelta: zoomLevel, longitudeDelta: zoomLevel)
                                }
                                else {
                                    zoomLevel = 0.05
                                    region.span = MKCoordinateSpan(latitudeDelta: zoomLevel, longitudeDelta: zoomLevel)
                                }
                            }
                    )
                }
                
            }.padding()
        }
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}
