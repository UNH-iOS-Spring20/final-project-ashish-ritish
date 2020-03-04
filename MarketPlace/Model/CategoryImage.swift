//
//  CategoryImage.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 3/4/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI

struct CategoryImage: View {
    var body: some View {
        Image("Iphone8")
        .resizable()
        .aspectRatio(contentMode: .fit)
        //.frame(width: 350, height: 300, alignment: .center)
    }
}

struct CategoryImage_Previews: PreviewProvider {
    static var previews: some View {
        CategoryImage()
    }
}
