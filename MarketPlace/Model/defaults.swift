//
//  defaults.swift
//  MarketPlace
//
//  Created by ritish karki on 4/22/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import Foundation

struct Defaults {
    
    static let (nameKey, addressKey, idKey, zipCodeKey, phoneNumberKey, emailKey, photoUrlKey, aboutKey) = ("name", "address", "id", "zipCode", "phoneNumber", "email", "photoUrl", "about")
    static let key = "user"
    
    private static let userDefault = UserDefaults.standard
    

    struct UserDetails {
        let name: String
        let address: String
        let id: String
        let zipCode: String
        let phoneNumber: String
        let photoUrl: String
        let about: String
        let email: String
        
        init(_ json: [String: String]) {
            self.name = json[nameKey] ?? ""
            self.address = json[addressKey] ?? ""
            self.id = json[idKey] ?? ""
            self.zipCode = json[zipCodeKey] ?? ""
            self.phoneNumber = json[phoneNumberKey] ?? ""
            self.email = json[emailKey] ?? ""
            self.photoUrl = json[photoUrlKey] ?? ""
            self.about = json[aboutKey] ?? ""
        }
    }
    
    static func save(name: String, address: String, id: String, zipCode: String, phoneNumber: String, email: String, photoUrl: String, about: String){
        userDefault.set([nameKey: name, addressKey: address, idKey: id, zipCodeKey: zipCode, phoneNumberKey:phoneNumber, emailKey: email, photoUrlKey: photoUrl, aboutKey: about],
                        forKey: key)
    }
    
    static func getUserDetails()-> UserDetails {
        return UserDetails((userDefault.value(forKey: key) as? [String: String]) ?? [:])
    }
    
    static func clearUserData(){
        userDefault.removeObject(forKey: key)
    }
}
