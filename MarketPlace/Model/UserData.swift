//
//  UserData.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 4/7/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI
import Combine


class UserData: ObservableObject {
    @Published var showFavoriteOnly = true
    @Published var products = FirebaseCollection<Product>(collectionRef: productsCollectionRef)
    
}
