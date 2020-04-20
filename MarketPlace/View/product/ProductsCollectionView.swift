//
//  ProductsCollectionView.swift
//  MarketPlace
//
//  Created by ritish karki on 4/20/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI

struct ProductsCollectionView: View {
    var products: [Product]
    
    var body: some View {
        let chunkedProducts = products.chunked(into: 2)
        
        return GeometryReader { geo in
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .leading, spacing: 0){
                    ForEach(0..<chunkedProducts.count, id: \.self) { index in
                        HStack(spacing:10) {
                            ForEach(chunkedProducts[index], id: \.self.id) { productData in
                                VStack(){
                                     NavigationLink(destination: ProductDetails(product: productData)) {
                                         ProductView(product: productData)
                                    }.buttonStyle(PlainButtonStyle())
                                }
                                .padding(.bottom, 10)
                                .frame(width: geo.size.width / 2 - 20)
                            }
                        }
                    }
                }.padding()
                .frame(width: geo.size.width)
            }
        }
    }
}

struct ProductsCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsCollectionView(
            products: Array(arrayLiteral: sampleProudct!)
        )
    }
}
