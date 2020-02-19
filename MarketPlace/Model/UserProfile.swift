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
        
        self.name = name
        self.email = email
        self.contactNumber = contactNumber
        self.zipCode = String
        self.address = address
        
    }
}
