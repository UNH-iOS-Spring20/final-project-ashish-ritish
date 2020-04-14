//
//  LoginPage.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 4/13/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI

struct LoginPage: View {
    @ObservedObject var viewRouter: ViewRouter
    var body: some View {
        Button(action : {
            self.viewRouter.currentPage = "homePage"
        }){
            HStack {
                Image(systemName: "bell.fill")
                Text("Login")
            }.padding(10.0)
                .overlay(
                    RoundedRectangle(cornerRadius: 10.0)
                        .stroke(lineWidth: 2.0)
            )
                .foregroundColor(Color.gray)
                .frame(minWidth: 120)
        }
    }
}



struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage(viewRouter: ViewRouter())
    }
}
