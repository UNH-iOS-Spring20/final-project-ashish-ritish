//
//  HomePage.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 4/13/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI

struct RootTabView: View {
    @ObservedObject var viewRouter: ViewRouter
    @State var showPopUp = false
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    @State var newUser = UserDefaults.standard.value(forKey: "NewUser") as? Bool ?? false
    
    init(viewRouter: ViewRouter) {
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: UIColor.darkGray,
            .font : UIFont(name: "Arial", size: 22)!]
        self.viewRouter = viewRouter
        
        checkUser { (exists, user) in
            if exists{
                UserDefaults.standard.set(false, forKey: "NewUser")
                UserDefaults.standard.set(user, forKey: "UserName")
                
                NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
            } else{
                UserDefaults.standard.set(true, forKey: "NewUser")
                NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
            }
        }
    }
    
    var body: some View {
        GeometryReader{ geometry in
            VStack{
                Spacer()
                
                if self.viewRouter.selectedTab == "home" {
                    HomeView(viewRouter: self.viewRouter)
                } else if self.viewRouter.selectedTab == "notification" {
                    NotificationView()
                }
                else if self.viewRouter.selectedTab == "sell" {
                    SellView()
                }
                else if self.viewRouter.selectedTab == "list" {
                    ListScreenView()
                }
                else if self.viewRouter.selectedTab == "add" {
                    AddProductView()
                }
                
                Spacer()
                
                ZStack {
                    
                    HStack(spacing: 0){
                        
                        VStack(){
                            Image(systemName: "house.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(0)
                                .frame(height: 23)
                            Text("Home")
                                .font(.system(size: 12))
                            
                        }
                        .frame(width: geometry.size.width/5, height: 75)
                        .foregroundColor(self.viewRouter.currentView == "home" ? Color("appBlue") : .gray)
                        .onTapGesture {
                            self.viewRouter.selectedTab = "home"
                            self.viewRouter.currentView = "home"
                            
                        }
                        
                        VStack(){
                            Image(systemName: "bell.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(0)
                                .frame(height: 23)
                            Text("Notification")
                                .font(.system(size: 12))
                        }
                        .frame(width: geometry.size.width/5, height: 75)
                        .foregroundColor(self.viewRouter.currentView == "notification" ? Color("appBlue") : .gray)
                        .onTapGesture {
                            self.viewRouter.selectedTab = "notification"
                            self.viewRouter.currentView = "notification"
                            
                        }
                        
                        ZStack {
                            Circle()
                                .foregroundColor(Color.white)
                                .frame(width: 65, height: 65)
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 65, height: 65)
                                .foregroundColor(Color("appBlue"))
                                .overlay(Circle().stroke(Color.white, lineWidth: 3))
                                .shadow(radius: 3)
                                .rotationEffect(Angle(degrees: self.showPopUp ? 180 : 0))
                        }
                        .offset(y: -geometry.size.height/10/2)
                        .onTapGesture {
                            
                            self.viewRouter.currentView = "add"
                            withAnimation{
                                self.showPopUp.toggle()
                            }
                            
                            
                        }
                        
                        VStack(){
                            Image(systemName: "gear")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(0)
                                .frame(width: geometry.size.width/6, height: 23)
                            Text("Chat")
                                .font(.system(size: 12))
                        }
                        .frame(width: geometry.size.width/5, height: 75)
                        .foregroundColor(self.viewRouter.currentView == "sell" ? Color("appBlue") : .gray)
                        .onTapGesture {
                            self.viewRouter.currentView = "sell"
                        }
                        
                        VStack(){
                            Image(systemName: "line.horizontal.3")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(0)
                                .frame(width: 27)
                            Text("List")
                                .font(.system(size: 12))
                        }
                        .frame(width: geometry.size.width/5, height: 75)
                        .foregroundColor(self.viewRouter.currentView == "list" ? Color("appBlue") : .gray)
                        .onTapGesture {
                            self.viewRouter.currentView = "list"
                            self.viewRouter.selectedTab = "list"
                        }
                        
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height/10)
                    .background(Color.white.shadow(radius: 2))
                }
                
            }
            .edgesIgnoringSafeArea(.bottom)
            .sheet(isPresented: self.$newUser) {
               CreateAccount(show: self.$newUser)
            }
        }
    }
}



struct RootTabView_Previews: PreviewProvider {
    static var previews: some View {
        RootTabView(viewRouter: ViewRouter())
    }
}
