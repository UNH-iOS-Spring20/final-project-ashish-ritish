//
//  ProductRow.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 3/4/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI

struct ProductRow: View {
    var product: Product
    var body: some View {
        HStack {
            product.image
                .resizable()
                .frame(width: 50, height: 50)
            Text(product.name)
            Spacer()
        }
    }
}

struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
           Group{
               ProductRow(product: productData[0])
                ProductRow(product: productData[1])
           }
           .previewLayout(.fixed(width: 300, height: 70))
    }
}
