//
//  FavoriteList.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 4/7/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI

struct FavoriteList: View {
    @State var showFavoriteOnly = true
    @ObservedObject private var products = FirebaseCollection<Product>(collectionRef: productsCollectionRef)
    
    var body: some View {
        NavigationView{
        VStack{
            if(products.items.filter{ $0.addBy != uid! && $0.soldTo.isEmpty && (!self.showFavoriteOnly || $0.favoriteList.contains(uid!))}.count > 0){
                ProductsCollectionView(products: self.products.items.filter{$0.addBy != uid! && $0.soldTo.isEmpty && (!self.showFavoriteOnly || $0.favoriteList.contains(uid!))})
            }else{
                noProduct(message: "You don't have any favorite items yet")
            }
        }
         .navigationBarTitle("Favorite", displayMode: .inline)
        }
    }
}

struct FavoriteList_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteList()
    }
}
