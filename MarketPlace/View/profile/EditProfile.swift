//
//  EditProfile.swift
//  MarketPlace
//
//  Created by Ashish-Ritish on 4/13/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI
import UserNotifications
import Firebase
import SDWebImageSwiftUI


struct EditProfile: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @State var name = Defaults.getUserDetails().name
    @State var about = Defaults.getUserDetails().about
    @State var phoneNumber = Defaults.getUserDetails().phoneNumber
    @State var zipCode = Defaults.getUserDetails().zipCode
    @State var location = Defaults.getUserDetails().address
    @State var picker = false
    @State var loading = false
    @State var imagedata : Data = .init(count: 0)
    @State var alert = false
    
    var body : some View{
        
        VStack(alignment: .leading, spacing: 15){
            HStack{
                
                Spacer()
                
                Button(action: {
                    
                    self.picker.toggle()
                    
                }) {
                    
                    if self.imagedata.count == 0{
                        
                        //                       Image(systemName: "person.crop.circle.badge.plus").resizable().frame(width: 90, height: 70).foregroundColor(.gray)
                        WebImage(url: URL(string: (Defaults.getUserDetails().photoUrl)))
                            .onSuccess { image, cacheType in
                                // Success
                        }
                        .resizable()
                            .placeholder(Image(systemName: "person.crop.circle")) // Placeholder Image
                            .renderingMode(.original)
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            .shadow(radius: 10)
                            //   .edgesIgnoringSafeArea(.top)
                            .scaledToFit()
                    }
                    else{
                        
                        Image(uiImage: UIImage(data: self.imagedata)!).resizable().renderingMode(.original).frame(width: 150, height: 150).clipShape(Circle())
                        
                    }
                    
                    
                }
                
                Spacer()
            }
            .padding(.top,15)
            .padding(.bottom,15)
            
            VStack(alignment: .leading){
                
                Text("Name").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                
                HStack{
                    
                    TextField("Enter Your Name", text: $name)
                    
                    if name != ""{
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
                Text("Phone Number").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                
                HStack{
                    TextField("Number", text: $phoneNumber)
                        .keyboardType(.numberPad)
                }
                
                Divider()
                
            }.padding(.bottom, 15)
            
            VStack(alignment: .leading){
                
                Text("Zip Code").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                
                HStack{
                    TextField("Enter your area Zip code", text: $zipCode)
                }
                
                Divider()
                
            }.padding(.bottom, 15)
            
            VStack(alignment: .leading){
                
                Text("Location").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                
                HStack{
                    TextField("Enter your location", text: $location)
                }
                
                Divider()
                
            }.padding(.bottom, 15)
            
            VStack(alignment: .leading){
                
                Text("About You").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                
                HStack{
                    
                    TextField("Write something about yourself", text: $about)
                    
                    if about != ""{
                        Image(systemName: "checkmark")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 23)
                            .foregroundColor(Color.init(.label))
                    }
                    
                }
                
                Divider()
                
            }.padding(.bottom, 15)
            
            if self.loading{
                HStack{
                    Spacer()
                    Indicator()
                    Spacer()
                }
            }
                
            else{
                Button(action: {
                    if self.name != "" && self.about != "" && self.imagedata.count != 0 && self.zipCode != "" && self.phoneNumber != "" && self.location != ""{
                        
                        self.loading.toggle()
                        
                        CreateUser(name: self.name, about: self.about, imagedata: self.imagedata, zipCode: self.zipCode, phoneNumber: self.phoneNumber, location: self.location) { (status, url) in
                            
                            if status{
                                
                                Defaults.save(name: self.name, address: self.location, id: uid!, zipCode: self.zipCode, phoneNumber: self.phoneNumber, email: Defaults.getUserDetails().email, photoUrl: url, about: self.about)
                                
                                CreateNotification(title: "Account Update", message: "Your account successfully updated", isPublic: false)
                                checkForNewUserExistence()
                                self.mode.wrappedValue.dismiss()
                            }
                        }
                    }
                }) {
                    Text("Update").frame(width: UIScreen.main.bounds.width - 30,height: 50)
                }.foregroundColor(.white)
                    .background(Color("appBlue"))
                    .cornerRadius(10)
                
            }
            
        }
        .padding()
        .sheet(isPresented: self.$picker, content: {
            ImagePicker(picker: self.$picker, imagedata: self.$imagedata)
        })
            .alert(isPresented: self.$alert) {
                Alert(title: Text("Message"), message: Text("Please Fill The Contents"), dismissButton: .default(Text("Ok")))
        }
    }
}

struct EditProfile_Previews: PreviewProvider {
    static var previews: some View {
        EditProfile()
    }
}


