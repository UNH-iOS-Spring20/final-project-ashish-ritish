//
//  CategoryList.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 3/25/20.
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
//                    WaterfallGrid(products.items.filter{$0.category == categoryName}) { productData in
//                        //     if(productData.category == self.categoryName){
//                        NavigationLink(destination: ProductDetails(product: productData)){
//                            ProductView(product: productData)
//                        }
//                    }
//                    .gridStyle(
//                            columnsInPortrait: 2,
//                            columnsInLandscape: 3,
//                            spacing: 15,
//                            padding: EdgeInsets(top: 7.5, leading: 15, bottom: 7.5, trailing: 15),
//                            animation: .easeInOut(duration: 0.5)
//                    )
//                    .scrollOptions(
//                            direction: .vertical,
//                            showsIndicators: true
//                    )
                }else{
                    noProduct(message: "Oops!!! Looks like there were no products in " + categoryName + " .")
                }
           
        }.padding(.top, 50)
        .navigationBarTitle(Text(categoryName), displayMode: .inline)
    }
}

struct CategoryList_Previews: PreviewProvider {
    static var previews: some View {
        CategoryList(categoryName: "Auto Motive")
    }
}
