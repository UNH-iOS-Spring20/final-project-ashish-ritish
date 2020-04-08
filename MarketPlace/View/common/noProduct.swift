//
//  noProduct.swift
//  MarketPlace
//
//  Created by ritish karki on 4/7/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI

struct noProduct: View {
    var body: some View {
        VStack{
            Text("Oops!! Looks like there were no products in this category.")
            Image("cart").resizable().aspectRatio(contentMode: .fit)
        }

    }
}

struct noProduct_Previews: PreviewProvider {
    static var previews: some View {
        noProduct()
    }
}
