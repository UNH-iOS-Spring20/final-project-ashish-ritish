//
//  SellView.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 3/19/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI

struct SellView: View {
    //  @State private var isNavigationBarHidden = true
    var body: some View {
        NavigationView{
            Color.purple
                .navigationBarTitle(Text("Sell"), displayMode: .inline)
        }
    }
}

struct SellView_Previews: PreviewProvider {
    static var previews: some View {
        SellView()
    }
}
