//
//  logInView.swift
//  MarketPlace
//
//  Created by ritish karki on 4/15/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI

struct logInView: View {
    @ObservedObject var viewRouter: ViewRouter
    @State var user = ""
    @State var pass = ""
    
    var body: some View {
        VStack{
            
            Image("cart").resizable().aspectRatio(contentMode: .fit).frame(width:165)
            
            Text("Sign In").fontWeight(.heavy).font(.largeTitle).padding([.top,.bottom], 20)
            
            VStack(alignment: .leading){
                
                VStack(alignment: .leading){
                    
                    Text("Username").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                    
                    HStack{
                        
                        TextField("Enter Your Username", text: $user)
                        
                        if user != ""{
                            Image(systemName: "checkmark")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 23)
                                .foregroundColor(Color.init(.label))
                        }
                        
                    }
                    
                    Divider()
                    
                }.padding(.bottom, 15)
                
                VStack(alignment: .leading){
                    
                    Text("Password").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                        
                    SecureField("Enter Your Password", text: $pass)
                    
                    Divider()
                }
                
                HStack{
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }) {
                        
                        Text("Forgot Password ?").foregroundColor(Color("appBlue").opacity(0.5))
                    }
                }

            }.padding(.horizontal, 6)
            
            
            socialLogin(viewRouter: viewRouter)
            
        }.padding()
    }
}

struct logInView_Previews: PreviewProvider {
    static var previews: some View {
        logInView(viewRouter: ViewRouter())
    }
}
