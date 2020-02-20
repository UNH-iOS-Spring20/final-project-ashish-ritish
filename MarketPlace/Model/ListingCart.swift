//
//  ListingCart.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 2/19/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

class ListingCart{
    var items = [ProductItem]()
    
    func listItem(item: ProductItem){
        items.append(item)
    }
    
}
