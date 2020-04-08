//
//  Category.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 4/8/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import FirebaseFirestore

class Category: FirebaseCodable {
    var id: String
    @Published var name: String
    
    var data: [String: Any]{
        return[
            "name": name
        ]
    }

    required init?(id: String, data: [String : Any]) {
        
        guard let name = data["name"] as? String
        else {
            return nil
        }
        
        self.id =  id
        self.name = name
    }
}
