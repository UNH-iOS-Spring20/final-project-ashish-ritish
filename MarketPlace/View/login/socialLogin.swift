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
    @State var show = false
    
    var body: some View {
        VStack{
            Text("(or)").foregroundColor(Color.gray.opacity(0.5)).padding(.top,30)
            GoogleSignView().frame(width:150, height:55)
            HStack(spacing: 8){
                
                Text("Don't Have An Account ?").foregroundColor(Color.gray)
                
                Button(action: {
                    self.show.toggle()
                }) {
                    
                   Text("Sign Up")
                    
                }.foregroundColor(Color("appBlue"))
                
            }.padding(.top, 25)
        }
        .sheet(isPresented: $show) {
            signUpView(show: self.$show)
        }
    }
}

struct socialLogin_Previews: PreviewProvider {
    static var previews: some View {
        socialLogin(viewRouter: ViewRouter())
    }
}
