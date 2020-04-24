//
//  EditProfile.swift
//  MarketPlace
//
//  Created by Ashish-Ritish on 4/13/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI
import UserNotifications

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
                        
                       Image(systemName: "person.crop.circle.badge.plus").resizable().frame(width: 90, height: 70).foregroundColor(.gray)
                    }
                    else{
                        
                        Image(uiImage: UIImage(data: self.imagedata)!).resizable().renderingMode(.original).frame(width: 90, height: 90).clipShape(Circle())
                    }
                    
                    
                }
                
                Spacer()
            }
            .padding(.vertical, 15)
            
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
                        print( self.name, self.about)
                        
                        CreateUser(name: self.name, about: self.about, imagedata: self.imagedata, zipCode: self.zipCode, phoneNumber: self.phoneNumber, location: self.location) { (status, url) in
                            
                            if status{
                                
                                Defaults.save(name: self.name, address: self.location, id: uid!, zipCode: self.zipCode, phoneNumber: self.phoneNumber, email: Defaults.getUserDetails().email, photoUrl: url, about: self.about)

                                CreateNotification(title: "Account Update", message: "User account successfully updated")
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
        .onAppear(){
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge,.sound,.alert]){ (_, _) in
                
            }
        }
    }
}

struct EditProfile_Previews: PreviewProvider {
    static var previews: some View {
        EditProfile()
    }
}

func CreateNotification( title: String, message: String){
    let content = UNMutableNotificationContent()
    content.title = title
    content.subtitle = message
    content.sound = UNNotificationSound.default
    
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
    
    let req = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    
    UNUserNotificationCenter.current().add(req, withCompletionHandler: nil)
}
