//
//  Product.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 3/4/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//


import FirebaseFirestore

class Product: FirebaseCodable {
    var id: String
    @Published var name: String
    @Published var price: Double
    @Published var email: String
    @Published var category: String
    @Published var condition: String
    @Published var imageName: String
    @Published var latitude: Double
    @Published var longitude: Double
    @Published var description: String
    @Published var isFavorite: Bool
    @Published var imageUrls: Array<String>
    
    
    var data: [String: Any]{
        return [
            "name": name,
            "price": price,
            "email": email,
            "category": category,
            "condtion": condition,
            "imageName": imageName,
            "latitude": latitude,
            "longitude": longitude,
            "description": description,
            "isFavorite": isFavorite,
            "imageUrls": imageUrls
        ]
    }
    
    
    required init?(id: String, data: [String: Any]){
        guard let name = data["name"] as? String,
            let price = data["price"] as? Double,
            let email = data["email"] as? String,
            let category = data["category"] as? String,
            let condition = data["condition"] as? String,
            let imageName = data["imageName"] as? String,
            let latitude = data["latitude"] as? Double,
            let longitude = data["longitude"] as? Double,
            let description = data["description"] as? String,
            let isFavorite = data["isFavorite"] as? Bool,
            let imageUrls = data["imageUrls"] as? Array<String>
            else{
                return nil
        }
        
        self.id =  id
        self.name = name
        self.price =  price
        self.email =  email
        self.category =  category
        self.condition =  condition
        self.imageName =  imageName
        self.latitude =  latitude
        self.longitude = longitude
        self.description =  description
        self.isFavorite = isFavorite
        self.imageUrls =  imageUrls
    }
    
    
}
