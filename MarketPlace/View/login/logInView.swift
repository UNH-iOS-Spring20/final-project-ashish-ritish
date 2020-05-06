//
//  logInView.swift
//  MarketPlace
//
//  Created by Ashish-Ritish on 4/15/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI

struct logInView: View {
    @ObservedObject var viewRouter: ViewRouter
    @State var user = ""
    @State var pass = ""
    @State var msg = ""
    @State var alert = false
    
    var body: some View {
        VStack{
            
            Image("cart").resizable().aspectRatio(contentMode: .fit).frame(width:165)
            
            Text("Sign In").fontWeight(.heavy).font(.largeTitle).padding([.top,.bottom], 20)
            
            VStack(alignment: .leading){
                
                VStack(alignment: .leading){
                    
                    Text("Email").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                    
                    HStack{
                        
                        TextField("Enter Your email", text: $user)
                        
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

            }.padding(.horizontal, 6)
            
            Button(action: {
            signInWithEmail(email: self.user, password: self.pass) { (verified, status) in
                               
                               if !verified{
                                   self.msg = status
                                   self.alert.toggle()
                               }
                               else{
                                    
                                   UserDefaults.standard.set(true, forKey: "status")
                                    checkForNewUserExistence()
                                   NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                               }
                           }
                           
                       }) {
                           
                           Text("Sign In").foregroundColor(.white).frame(width: UIScreen.main.bounds.width - 120).padding()
                           
                           
            }.background(Color("appBlue"))
           .clipShape(Capsule())
           .padding(.top, 45)
            
            socialLogin(viewRouter: viewRouter)
            
        }.padding()
        .alert(isPresented: $alert) {
            Alert(title: Text("Login Error"),
                message: Text(self.msg),
                dismissButton: Alert.Button.default(
                    Text("Ok"), action: { self.user = ""; self.pass = "" }
                )
            )
        }
    }
}

struct logInView_Previews: PreviewProvider {
    static var previews: some View {
        logInView(viewRouter: ViewRouter())
    }
}

func checkForNewUserExistence(){
    
    checkUser { (exists, user) in
        if exists{
            UserDefaults.standard.set(false, forKey: "NewUser")
            UserDefaults.standard.set(user, forKey: "UserName")
            
        } else{
            UserDefaults.standard.set(true, forKey: "NewUser")
        }
        NotificationCenter.default.post(name: NSNotification.Name("newUser"),object: nil)
    }

}


