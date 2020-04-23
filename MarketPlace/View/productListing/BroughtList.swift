//
//  BroughtList.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 4/22/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI

struct BroughtList: View {
    @ObservedObject private var products = FirebaseCollection<Product>(collectionRef: productsCollectionRef)
    var body: some View {
        VStack{
            if(products.items.filter{ $0.soldTo == uid!}.count > 0){
                ProductsCollectionView(products: self.products.items.filter{$0.soldTo == uid!})
            }else{
                noProduct(message: "You don't have any selling items yet")
            }
        }
    }
}

struct BroughtList_Previews: PreviewProvider {
    static var previews: some View {
        BroughtList()
    }
}
