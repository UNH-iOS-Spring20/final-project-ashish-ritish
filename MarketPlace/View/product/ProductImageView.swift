//
//  ProductImageView.swift
//  MarketPlace
//
//  Created by Ashish-Ritish on 4/7/20.
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
            HStack{
                Spacer()
            PageControl(numberOfPages: viewControllers.count, currentPage: $currentPage)
            Spacer()
            }.padding(.bottom, 20)
        }
    }
}

var urls = [
    "https://firebasestorage.googleapis.com/v0/b/marketplace-71120.appspot.com/o/Real%20State%2FGhar%2F00B0B_imKuvG07Bhf_600x450.jpg?alt=media&token=b8ef0d5c-dbea-4d71-a6a3-c25416792262",
    "https://firebasestorage.googleapis.com/v0/b/marketplace-71120.appspot.com/o/Real%20State%2FGhar%2F00m0m_7xa163K3Jyc_600x450.jpg?alt=media&token=2a8749ec-e810-4729-83f6-33faaebde207",
    "https://firebasestorage.googleapis.com/v0/b/marketplace-71120.appspot.com/o/Real%20State%2FGhar%2F00P0P_57FBcuR9IdY_600x450.jpg?alt=media&token=66afdb55-51f2-4ca7-9053-b906afab8f16"]

struct ProductImageView_Previews: PreviewProvider {
    static var previews: some View {
        ProductImageView(urls.map { ProductImage(picture: $0) })
        .aspectRatio(contentMode: .fit)
    }
}
