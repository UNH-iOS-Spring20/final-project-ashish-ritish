//
//  Favorite.swift
//  MarketPlace
//
//  Created by Ashish-Ritish on 4/22/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import FirebaseFirestore

class Favorite: FirebaseCodable {
    var id: String
    @Published var productId: String
    
    
    var data: [String: Any]{
        return[
            "productId": productId
        ]
    }
    
    required init?(id: String, data: [String : Any]) {
        
        guard let productId = data["productId"] as? String
            else {
                return nil
        }
        
        self.id =  id
        self.productId = productId
    }
}
