//
//  notification.swift
//  MarketPlace
//
//  Created by ritish karki on 3/22/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

struct Notification: Identifiable {
    var id: String
    var title: String
    var description: String
    var createdTime: Int
    var seenTime: Int
}

extension Notification: FirebaseCodable {
    init?(id: String, dictionary: [String : Any]) {
        
        guard let title = dictionary["title"] as? String,
            let description = dictionary["description"] as? String,
            let createdTime = dictionary["createdTime"] as? Int,
            let seenTime = dictionary["seenTime"] as? Int
        else {
            return nil
        }
        
        self.init(id: id,
                  title:title,
                  description:description,
                  createdTime:createdTime,
                  seenTime:seenTime)
    }
}
