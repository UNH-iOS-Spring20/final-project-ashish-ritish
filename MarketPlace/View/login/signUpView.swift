//
//  signUpView.swift
//  MarketPlace
//
//  Created by ritish karki on 4/15/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI

struct signUpView: View {
    @ObservedObject var viewRouter: ViewRouter
    @State var user = ""
    @State var pass = ""
    @State var rePass = ""
    
    var body: some View {
        VStack{
            
            Image("cart").resizable().aspectRatio(contentMode: .fit).frame(width:165)
            
            Text("Register").fontWeight(.heavy).font(.largeTitle).padding([.top,.bottom], 20)
            
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
                    
                    Text("Email").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                    
                    HStack{
                        
                        TextField("Enter Your Email", text: $user)
                        
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
                }.padding(.bottom, 15)
                
                VStack(alignment: .leading){
                    
                    Text("Re-Enter Password").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                        
                    SecureField("Re-Enter Your Password", text: $rePass)
                    
                    Divider()
                }
                
                Button(action: {
                    self.viewRouter.currentPage = "homePage"
                }) {
                    
                    Text("Register").foregroundColor(.white).frame(width: UIScreen.main.bounds.width-70).padding()
                    
                    
                }.background(Color("appBlue"))
                .clipShape(Capsule())
                .padding(.top, 45)

            }.padding(.horizontal, 20)
        }.padding()
    }
}

struct signUpView_Previews: PreviewProvider {
    static var previews: some View {
        signUpView(viewRouter: ViewRouter())
    }
}
