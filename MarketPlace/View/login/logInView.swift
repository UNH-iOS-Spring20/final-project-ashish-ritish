//
//  logInView.swift
//  MarketPlace
//
//  Created by Ashish-Ritish on 4/15/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//
import Firebase

import SwiftUI

struct logInView: View {
    @ObservedObject var viewRouter: ViewRouter
    @State var email = ""
    @State var pass = ""
    @State var msg = ""
    @State var alertTitle = "Login Error"
    @State var alert = false
    @State var visible = false
    
    func reset(){
        if self.email != ""{
            Auth.auth().sendPasswordReset(withEmail: self.email) { (err) in
                if err != nil{
                    self.msg = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
                self.alertTitle = "Reset Link Sent"
                self.msg = "Please check your email to reset password."
                self.alert.toggle()
            }
        }
        else{
            self.msg = "Please enter the email"
            self.alert.toggle()
        }
    }
    
    
    var body: some View {
        VStack{
            
            Image("cart").resizable().aspectRatio(contentMode: .fit).frame(width:165)
            
            Text("Sign In").fontWeight(.heavy).font(.largeTitle).padding([.top,.bottom], 20)
            
            VStack(alignment: .leading){
                
                VStack(alignment: .leading){
                    
                    Text("Email").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                    
                    HStack{
                        
                        TextField("Enter Your email", text: $email).autocapitalization(.none)
                        
                        if isValidEmail(email: self.email){
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
                    HStack(spacing: 15){
                        VStack{
                            if self.visible{
                                TextField("Password", text: self.$pass)
                                    .autocapitalization(.none)
                            }
                            else{
                                SecureField("Password", text: self.$pass)
                                    .autocapitalization(.none)
                            }
                        }
                        
                        Button(action: {
                            self.visible.toggle()
                        }) {
                            Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(Color("appBlue"))
                        }
                    }
                    Divider()
                }
                
                HStack{
                    Spacer()
                    Button(action: {
                        self.reset()
                    }) {
                        Text("Forgot Password ?")
                            .foregroundColor(Color("appBlue"))
                    }
                }
                .padding(.top, 20)
                
            }.padding(.horizontal, 6)
            
            Button(action: {
                signInWithEmail(email: self.email, password: self.pass) { (verified, status) in
                    
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
                .padding(.top, 25)
            
            socialLogin(viewRouter: viewRouter)
            
        }.padding()
            .alert(isPresented: $alert) {
                Alert(title: Text(self.alertTitle),
                      message: Text(self.msg),
                      dismissButton: Alert.Button.default(
                        Text("Ok"), action: { self.email = ""; self.pass = "" }
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


