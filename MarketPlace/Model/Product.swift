//
//  Product.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 3/4/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//


import CoreLocation

struct Product: Hashable, Codable, Identifiable {
    var id: String
    var name: String
    var price: Double
    var email: String
    var category: String
    var condition: String
    var imageName: String
    var latitude: Double
    var longitude: Double
    var description: String
    var isFavorite: Bool
    var imageUrls: Array<String>
}

extension Product: FirebaseCodable {
    
    init?(id: String, dictionary: [String : Any]) {
        guard let name = dictionary["name"] as? String,
            let price = dictionary["price"] as? Double,
            let email = dictionary["email"] as? String,
            let category = dictionary["category"] as? String,
            let condition = dictionary["condition"] as? String,
            let imageName = dictionary["imageName"] as? String,
            let latitude = dictionary["latitude"] as? Double,
            let longitude = dictionary["longitude"] as? Double,
            let description = dictionary["description"] as? String,
            let isFavorite = dictionary["isFavorite"] as? Bool,
            let imageUrls = dictionary["imageUrls"] as? Array<String>
        else {
            return nil
        }
        
        self.init(id: id,
                  name: name,
                  price: price,
                  email: email,
                  category: category,
                  condition: condition,
                  imageName: imageName,
                  latitude: latitude,
                  longitude: longitude,
                  description: description,
                  isFavorite: isFavorite,
                  imageUrls: imageUrls)
    }
}
