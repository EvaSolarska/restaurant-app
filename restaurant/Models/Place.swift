//
//  Place.swift
//  restaurant
//
//  Created by Ewa Solarska on 29/08/2023.
//

import Foundation
import MapKit

struct Place: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}
