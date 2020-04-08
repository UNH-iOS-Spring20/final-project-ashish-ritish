//
//  FavoriteList.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 4/7/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI
import WaterfallGrid

struct FavoriteList: View {
    @EnvironmentObject var userData: UserData
 //   @State var showFavoriteOnly = true
   // @ObservedObject private var products = FirebaseCollection<Product>(collectionRef: productsCollectionRef)
    
    var body: some View {
        WaterfallGrid(userData.products.items.filter{!self.userData.showFavoriteOnly || $0.isFavorite}) { productData in
            NavigationLink(destination: ProductDetails(product: productData, fav: productData.isFavorite)){
                ProductView(product: productData)
            }
        }
        .gridStyle(
            columnsInPortrait: 2,
            columnsInLandscape: 3,
            spacing: 15,
            padding: EdgeInsets(top: 7.5, leading: 15, bottom: 7.5, trailing: 15),
            animation: .easeInOut(duration: 0.5)
        )
            .scrollOptions(
                direction: .vertical,
                showsIndicators: true
        )
        
    }
}

struct FavoriteList_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteList()
    }
}
