//
//  notification.swift
//  MarketPlace
//
//  Created by Ashish-Ritish on 3/22/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//
import FirebaseFirestore

class Notification: FirebaseCodable{
    var id: String
    @Published var title: String
    @Published var description: String
    @Published var createdTime: Int
    @Published var seenTime: Int
    
    var data: [String: Any]{
        return[
            "title": title,
            "description": description,
            "createdTime": createdTime,
            "seenTime": seenTime
        ]
    }
    
    required init?(id: String, data: [String : Any]) {
        
        guard let title = data["title"] as? String,
            let description = data["description"] as? String,
            let createdTime = data["createdTime"] as? Int,
            let seenTime = data["seenTime"] as? Int
            else {
                return nil
        }
        
        self.id = id
        self.title = title
        self.description = description
        self.createdTime = createdTime
        self.seenTime = seenTime
    }
}
