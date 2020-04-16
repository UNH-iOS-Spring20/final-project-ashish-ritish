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
    @Published var phoneNumber: String
    @Published var zipCode: String
    @Published var address: String
    @Published var photoUrl: String
    @Published var about: String
    
    var data: [String: Any]{
        return[
            "name": name,
            "email": email,
            "phoneNumber": phoneNumber,
            "zipCode": zipCode,
            "address": address,
            "about": about,
            "photoUrl": photoUrl
        ]
    }
    

    required init?(id: String, data: [String: Any]) {
        guard let name = data["name"] as? String,
        let email = data["email"] as? String,
        let phoneNumber = data["phoneNumber"] as? String,
        let zipCode = data["zipCode"] as? String,
        let address = data["address"] as? String,
        let about = data["about"] as? String,
        let photoUrl = data["photoUrl"] as? String
            else{
                return nil
        }
        
        self.id = id
        self.name = name
        self.email = email
        self.phoneNumber = phoneNumber
        self.zipCode = zipCode
        self.address = address
        self.photoUrl = photoUrl
        self.about = about
    }
}
