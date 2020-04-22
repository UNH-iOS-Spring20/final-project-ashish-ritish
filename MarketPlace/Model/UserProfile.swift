//
//  UserProfile.swift
//  MarketPlace
//
//  Created by Ashish-Ritish on 2/19/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//
import Foundation

class UserProfile: ObservableObject{
    @Published var id = ""
    @Published var name = ""
    @Published var email = ""
    @Published var phoneNumber = ""
    @Published var zipCode = ""
    @Published var address = ""
    @Published var photoUrl = ""
    @Published var about = ""
}
