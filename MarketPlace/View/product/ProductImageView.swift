//
//  ProductImageView.swift
//  MarketPlace
//
//  Created by ritish karki on 4/7/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI

struct ProductImageView<Page: View>: View {
    var viewControllers: [UIHostingController<Page>]
    @State var currentPage = 0
    
    init(_ views: [Page]) {
        self.viewControllers = views.map { UIHostingController(rootView: $0) }
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            ProductImageViewController(controllers: viewControllers, currentPage: $currentPage)
            PageControl(numberOfPages: viewControllers.count, currentPage: $currentPage)
            .padding(.trailing)
        }
    }
}

var urls = [
       "https://firebasestorage.googleapis.com/v0/b/marketplace-71120.appspot.com/o/BMW.png?alt=media&token=aca57096-47ee-46d9-86e2-f81c81cb0c14", "https://cdn.pixabay.com/photo/2016/02/13/13/11/cuba-1197800_1280.jpg", "https://firebasestorage.googleapis.com/v0/b/marketplace-71120.appspot.com/o/BMW.png?alt=media&token=aca57096-47ee-46d9-86e2-f81c81cb0c14"]
   
struct ProductImageView_Previews: PreviewProvider {
    static var previews: some View {
        ProductImageView(urls.map { ProductImage(picture: $0) })
        .aspectRatio(3/2, contentMode: .fit)
    }
}
