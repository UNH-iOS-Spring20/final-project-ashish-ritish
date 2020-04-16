//
//  signUpView.swift
//  MarketPlace
//
//  Created by ritish karki on 4/15/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct signUpView: View {
    @Binding var show : Bool
    @State var email = ""
    @State var pass = ""
    @State var alert = false
    @State var msg = ""
    
    var body: some View {
        VStack{
            
            Image("cart").resizable().aspectRatio(contentMode: .fit).frame(width:165)
            
            Text("Register").fontWeight(.heavy).font(.largeTitle).padding([.top,.bottom], 20)
            
            VStack(alignment: .leading){
                
                VStack(alignment: .leading){
                    
                    Text("Email").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                    
                    HStack{
                        
                        TextField("Enter Your Email", text: $email)
                        
                        if email != ""{
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
                
                Button(action: {
                    signIupWithEmail(email: self.email, password: self.pass) { (verified, status) in
                        
                        if !verified{
                            
                            self.msg = status
                            self.alert.toggle()
                            
                        }
                        else{
                            
                            UserDefaults.standard.set(true, forKey: "status")
                            
                            self.show.toggle()
                            
                            NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                        }
                    }
                }) {
                    
                    Text("Register").foregroundColor(.white).frame(width: UIScreen.main.bounds.width-70).padding()
                    
                    
                }.background(Color("appBlue"))
                .clipShape(Capsule())
                .padding(.top, 45)

            }.padding(.horizontal, 20)
        }.padding()
        .alert(isPresented: $alert) {
            Alert(title: Text("Error"), message: Text(self.msg), dismissButton: .default(Text("Ok")))
        }
    }
}

func signIupWithEmail(email: String,password : String,completion: @escaping (Bool,String)->Void){
    
    Auth.auth().createUser(withEmail: email, password: password) { (res, err) in
    
        if err != nil{
            completion(false,(err?.localizedDescription)!)
            return
        }
        
        completion(true,(res?.user.email)!)
    }
}


struct signUpView_Previews: PreviewProvider {
    static var previews: some View {
        signUpView(show: .constant(false))
    }
}
