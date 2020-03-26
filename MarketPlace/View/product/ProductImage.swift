//
//  CategoryImage.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 3/4/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductImage: View {
    var picture: String
    
    var body: some View {
           // .frame(width: 250, height: 250, alignment: .center)
        WebImage(url: URL(string: picture))
               .onSuccess { image, cacheType in
                   // Success
               }
               .resizable() // Resizable like SwiftUI.Image, you must use this modifier or the view will use the image bitmap size
               .placeholder(Image(systemName: "photo")) // Placeholder Image
               // Supports ViewBuilder as well
               .placeholder {
                   Rectangle().foregroundColor(.gray)
               }
               .renderingMode(.original)
               .indicator(.activity) // Activity Indicator
               .animation(.easeInOut(duration: 0.5)) // Animation Duration
               .transition(.fade) // Fade Transition
               .scaledToFit()
               .frame(alignment: .center)        
//        .renderingMode(.original)
//        .resizable()
//        .layoutPriority(97)
//        .aspectRatio(contentMode: .fit)
//        .clipped()
    }
}

struct ProductImage_Previews: PreviewProvider {
    static var previews: some View {
        ProductImage(picture: firebaseSession.products[0].imageName)
    }
}

