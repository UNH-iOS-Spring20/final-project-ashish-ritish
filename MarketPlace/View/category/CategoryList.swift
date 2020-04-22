//
//  CategoryList.swift
//  MarketPlace
//
//  Created by Ashish-Ritish on 3/25/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI


struct CategoryList: View {
    var categoryName: String
    @ObservedObject private var products = FirebaseCollection<Product>(collectionRef: productsCollectionRef)
    
    var body: some View {
        VStack{
                if(products.items.filter{$0.category == categoryName}.count > 0){

                    ProductsCollectionView(products: self.products.items.filter{$0.category == categoryName})

                }else{
                    noProduct(message: "Oops!!! Looks like there were no products in " + categoryName + " .")
                }
           
        }.padding(0)
        .navigationBarTitle(Text(categoryName), displayMode: .inline)
    }
}

struct CategoryList_Previews: PreviewProvider {
    static var previews: some View {
        CategoryList(categoryName: "Auto Motive")
    }
}
