//
//  noProduct.swift
//  MarketPlace
//
//  Created by Ashish-Ritish on 4/7/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI

struct noProduct: View {
    var message: String
    
    var body: some View {
        VStack(alignment: .leading){
            Text(message)
                .font(.system(size: 20))
                .fontWeight(.light)
                .foregroundColor(Color("appBlue"))
            Image("cart").resizable().aspectRatio(contentMode: .fit)
        }.padding()
    }
}

struct noProduct_Previews: PreviewProvider {
    static var previews: some View {
        noProduct(message: "Looks like there were no products in this category.")
    }
}
