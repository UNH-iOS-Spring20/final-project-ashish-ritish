//
//  Product.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 3/4/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI
import CoreLocation

struct Product: Hashable, Codable, Identifiable {
    
    var id = UUID()
    var name: String
    var price: Double
    var email: String
    var category: String
    var condition: String
    var imageName: String
    var latitude: Double
    var longitude: Double
    var description: String
    
 //   fileprivate var coordinates: Coordinates
  //  fileprivate var imageName: String

/*    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    } */

  /*  enum Category: String, CaseIterable, Codable, Hashable {
        case featured = "Featured"
        case vechiles = "Vechiles"
        case electronics = "Electronics"
        case fashion = "Fashion"
        case house = "House"
        case sport = "Sport"
        case other = "Other"
    } */
}

extension Product {
    var image: Image {
        ImageStore.shared.image(name: imageName)
    }
} 

struct Coordinates: Hashable, Codable {
    var latitude: Double
    var longitude: Double
}
