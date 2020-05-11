//
//  Product.swift
//  MarketPlace
//
//  Created by Ashish-Ritish on 3/4/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//


import FirebaseFirestore

class Product: FirebaseCodable, Identifiable {
    var id: String
    @Published var name: String
    @Published var price: Double
    @Published var email: String
    @Published var category: String
    @Published var condition: String
    @Published var latitude: Double
    @Published var longitude: Double
    @Published var description: String
    @Published var addBy: String
    @Published var soldTo: String
    @Published var imageUrls: Array<String>
    @Published var favoriteList: Array<String>
    
    
    var data: [String: Any] {
        return [
            "name": name,
            "price": price,
            "email": email,
            "category": category,
            "condition": condition,
            "latitude": latitude,
            "longitude": longitude,
            "description": description,
            "addBy": addBy,
            "soldTo": soldTo,
            "imageUrls": imageUrls,
            "favoriteList": favoriteList
        ]
    }
    
    
    required init?(id: String, data: [String: Any]){
        guard let name = data["name"] as? String,
            let price = data["price"] as? Double,
            let email = data["email"] as? String,
            let category = data["category"] as? String,
            let condition = data["condition"] as? String,
            let latitude = data["latitude"] as? Double,
            let longitude = data["longitude"] as? Double,
            let description = data["description"] as? String,
            let addBy = data["addBy"] as? String,
            let soldTo = data["soldTo"] as? String,
            let imageUrls = data["imageUrls"] as? Array<String>,
            let favoriteList = data["favoriteList"] as? Array<String>
            else{
                return nil
        }
        
        self.id =  id
        self.name = name
        self.price =  price
        self.email =  email
        self.category =  category
        self.condition =  condition
        self.latitude =  latitude
        self.longitude = longitude
        self.description =  description
        self.addBy = addBy
        self.soldTo = soldTo
        self.imageUrls =  imageUrls
        self.favoriteList = favoriteList
    }
    
    #if DEBUG
    static let example = Product(
        id: "12s4", data: [
            "name": "guitar",
            "price": 1000.0,
            "email": "karki.ritish@gmail.com",
            "category": "Music",
            "condition": "new",
            "latitude": 41.28758535034469,
            "longitude": -72.96590875763593,
            "description": "very nice guitar",
            "addBy": "bvnzARwG0jX8W2EhufM7X6u3FiG2",
            "soldTo": "",
            "imageUrls": ["https://firebasestorage.googleapis.com/v0/b/marketplace-71120.appspot.com/o/Computer%2FbvnzARwG0jX8W2EhufM7X6u3FiG2DesktopN9znYBvC?alt=media&token=df6aaccb-4c42-4dc7-9cf9-3b4f1b64e34b"],
            "favoriteList": [""]
        ]
    )
    #endif
}
