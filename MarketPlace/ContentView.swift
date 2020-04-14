//
//  ContentView.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 2/17/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack{
            if self.viewRouter.currentPage == "homePage"{
                HomePage(viewRouter: viewRouter)
            }else if self.viewRouter.currentPage == "loginPage"{
                LoginPage(viewRouter: viewRouter)
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewRouter: ViewRouter())
    }
}
