//
//  socialLogin.swift
//  MarketPlace
//
//  Created by ritish karki on 4/15/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI

struct socialLogin: View {
    @ObservedObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack{
            
            Button(action: {
                self.viewRouter.currentPage = "homePage"
            }) {
                
                Text("Sign In").foregroundColor(.white).frame(width: UIScreen.main.bounds.width - 120).padding()
                
                
            }.background(Color("appBlue"))
            .clipShape(Capsule())
            .padding(.top, 45)
            
            Text("(or)").foregroundColor(Color.gray.opacity(0.5)).padding(.top,30)
            
            HStack{
                
                Button(action: {
                    
                }) {
                    
                    Image("google").renderingMode(.original).padding()
                    
                    
                }.background(Color("appBlue").opacity(0.2))
                .clipShape(Circle())
                
            }.padding(.top, 25)
            
            HStack(spacing: 8){
                
                Text("Don't Have An Account ?").foregroundColor(Color.gray)
                
                Button(action: {
                    self.viewRouter.currentPage = "signupPage"
                }) {
                    
                   Text("Sign Up")
                    
                }.foregroundColor(Color("appBlue"))
                
            }.padding(.top, 25)
        }
    }
}

struct socialLogin_Previews: PreviewProvider {
    static var previews: some View {
        socialLogin(viewRouter: ViewRouter())
    }
}
