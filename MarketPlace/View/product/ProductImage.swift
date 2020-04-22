//
//  CategoryImage.swift
//  MarketPlace
//
//  Created by Ashish-Ritish on 3/4/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductImage: View {
    var picture: String
    var setHeight: Bool
    
    var body: some View {
        if (self.setHeight){
            return WebImage(url: URL(string: picture))
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
            .frame(height:175, alignment: .center)
        }else{
            return WebImage(url: URL(string: picture))
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
        }
    }
}

struct ProductImage_Previews: PreviewProvider {
    static var previews: some View {
        ProductImage(picture: "https://firebasestorage.googleapis.com/v0/b/marketplace-71120.appspot.com/o/BMW.png?alt=media&token=aca57096-47ee-46d9-86e2-f81c81cb0c14", setHeight:false)
    }
}

