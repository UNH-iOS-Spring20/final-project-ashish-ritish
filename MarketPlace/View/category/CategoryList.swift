//
//  CategoryList.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 3/25/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI
import WaterfallGrid

struct CategoryList: View {
    var categoryName: String
    var products = firebaseSession.products
    
    
    var body: some View {
        VStack{
            NavigationView {
                WaterfallGrid(products.filter{$0.category == categoryName}) { productData in
                    //     if(productData.category == self.categoryName){
                    NavigationLink(destination: ProductDetails(product: productData)){
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
            }.navigationBarTitle(categoryName)
            
        }.padding(.top, 10)
    }
}

struct CategoryList_Previews: PreviewProvider {
    static var previews: some View {
        CategoryList(categoryName: firebaseSession.categories[0].name)
    }
}
