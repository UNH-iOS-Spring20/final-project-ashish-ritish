//
//  CategoryImage.swift
//  MarketPlace
//
//  Created by Ashish-Ritish on 3/17/20.
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
                 Circle().stroke(Color.white, lineWidth: 2)
            )
            .frame(width: 50, height: 50, alignment: .center)
             .shadow(radius: 4)
            .aspectRatio(contentMode: .fit)
    }
}

struct CategoryImage_Previews: PreviewProvider {
    static var previews: some View {
        CategoryImage(picture: "Auto Motive")
    }
}
