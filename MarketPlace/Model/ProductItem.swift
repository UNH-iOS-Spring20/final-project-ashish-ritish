//  File.swift
//  MarketPlace
//
//  Created by Ashish Shrestha and Ritish Karki on 2/19/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.

class ProductItem{
    var name: String
    var price: Double
    var category: String
    var condition: String
    var email: String
    var date: String
    
    init?(name: String, category: String, condition: String, email: String, date: String, price: Double) {
        if name.isEmpty || category.isEmpty || email.isEmpty || date.isEmpty || price < 0{
            return nil
        }
        
        self.name = name
        self.category = category
        self.condition = condition
        self.email = email
        self.date = date
        self.price = price
        
    }
    
}
