//
//  SellingList.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 4/7/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI

struct SellingList: View {
    var body: some View {
        noProduct(message: "You haven't listed any thing to sell.")
    }
}

struct SellingList_Previews: PreviewProvider {
    static var previews: some View {
        SellingList()
    }
}
