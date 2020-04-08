//
//  ListingCart.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 2/19/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

class ListingCart{
    var items = [Product]()
    
    func listItem(item: Product){
        items.append(item)
    }

    func returnTotal() -> Double{
        var total: Double = 0.0
        for item in items{
            total += item.price
        }
        return total
    }
    
}
