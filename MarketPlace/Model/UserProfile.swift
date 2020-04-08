//
//  UserProfile.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 2/19/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//
import FirebaseFirestore

class UserProfile: FirebaseCodable{
    var id: String
    @Published var name: String
    @Published var email: String
    @Published var contactNumber: String
    @Published var zipCode: String
    @Published var address: String
    
    var data: [String: Any]{
        return[
            "name": name,
            "email": email,
            "contactNumber": contactNumber,
            "zipCode": zipCode,
            "address": address
        ]
    }
    

    required init?(id: String, data: [String: Any]) {
        guard let name = data["name"] as? String,
        let email = data["email"] as? String,
        let contactNumber = data["contactNumber"] as? String,
        let zipCode = data["zipCode"] as? String,
        let address = data["address"] as? String
            else{
                return nil
        }
        
        self.id = id
        self.name = name
        self.email = email
        self.contactNumber = contactNumber
        self.zipCode = zipCode
        self.address = address
        
    }
}
