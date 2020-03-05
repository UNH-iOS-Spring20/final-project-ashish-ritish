//
//  UserProfile.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 2/19/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

class UserProfile{
    var name: String
    var email: String
    var contactNumber: String
    var zipCode: String
    var address: String

    init?(name: String, email: String, contactNumber: String, zipCode: String, address: String) {
        if name.isEmpty || email.isEmpty || contactNumber.isEmpty{
            return nil
        }
        
        self.name = "Ritish Karki"
        self.email = "rkark1@unh.newhaven,edu"
        self.contactNumber = "2034353851"
        self.zipCode = "06516"
        self.address = "21 Andrew Street"
        
    }
}
