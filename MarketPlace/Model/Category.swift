//
//  Category.swift
//  MarketPlace
//
//  Created by ritish karki on 3/17/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

struct Category: Identifiable {
    var id: String
    var name: String
}

extension Category: FirebaseCodable {
    init?(id: String, dictionary: [String : Any]) {
        
        guard let name = dictionary["name"] as? String
        else {
            return nil
        }
        
        self.init(id: id,name:name)
    }
}
