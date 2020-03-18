//
//  CategoryImage.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 3/17/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI

struct CategoryImage: View {
    var picture: String
    
    var body: some View {
        Image(picture)
            .renderingMode(.original)
            .resizable()
            .clipShape(Circle())
            .overlay(
                 Circle().stroke(Color.white, lineWidth: 4))
            .frame(width: 90, height: 90)
             .shadow(radius: 10)
            .aspectRatio(contentMode: .fit)
    }
}

struct CategoryImage_Previews: PreviewProvider {
    static var previews: some View {
        CategoryImage(picture: categoryDatas[0].image)
    }
}
