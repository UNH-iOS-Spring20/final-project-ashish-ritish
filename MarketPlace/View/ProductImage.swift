//
//  CategoryImage.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 3/4/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI

struct ProductImage: View {
    var picture: String
    
    var body: some View {
        Image(picture)
            .resizable()
            .aspectRatio(contentMode: .fit)
        //.frame(width: 350, height: 300, alignment: .center)
    }
}

struct ProductImage_Previews: PreviewProvider {
    static var previews: some View {
        ProductImage(picture: productDatas[0].imageName)
    }
}

