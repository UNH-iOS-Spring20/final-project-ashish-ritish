//
//  HomePage.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 4/13/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI

struct HomePage: View {
    @ObservedObject var viewRouter: ViewRouter
    @State var showPopUp = false
    
    init(viewRouter: ViewRouter) {
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: UIColor.darkGray,
            .font : UIFont(name: "Arial", size: 22)!]
        self.viewRouter = viewRouter
    }
    
    var body: some View {
        GeometryReader{ geometry in
            VStack{
                Spacer()
                
                if self.viewRouter.currentView == "home" {
                    HomeView(viewRouter: self.viewRouter)
                } else if self.viewRouter.currentView == "notification" {
                    NotificationView()
                }
                else if self.viewRouter.currentView == "sell" {
                    SellView()
                }
                else if self.viewRouter.currentView == "list" {
                    ListScreenView()
                }
                else if self.viewRouter.currentView == "add" {
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
                            
                        .foregroundColor(self.viewRouter.itemColor == "home" ? .blue : .gray)
                        .onTapGesture {
                            self.viewRouter.currentView = "home"
                            self.viewRouter.itemColor = "home"
                            
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
                        .foregroundColor(self.viewRouter.itemColor == "notification" ? .blue : .gray)
                        .onTapGesture {
                            self.viewRouter.currentView = "notification"
                            self.viewRouter.itemColor = "notification"
                            
                        }
                        ZStack {
                            Circle()
                                .foregroundColor(Color.white)
                                .frame(width: 65, height: 65)
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 65, height: 65)
                                .foregroundColor(.blue)
                                .overlay(Circle().stroke(Color.white, lineWidth: 3))
                                .shadow(radius: 3)
                                .rotationEffect(Angle(degrees: self.showPopUp ? 180 : 0))
                        }
                        .offset(y: -geometry.size.height/10/2)
                            
                        .onTapGesture {
                            
                            self.viewRouter.currentView = "add"
                            self.viewRouter.itemColor = "add"
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
                        .foregroundColor(self.viewRouter.itemColor == "sell" ? .blue : .gray)
                        .onTapGesture {
                            self.viewRouter.currentView = "sell"
                            self.viewRouter.itemColor = "sell"
                            
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
                        .foregroundColor(self.viewRouter.itemColor == "list" ? .blue : .gray)
                        .onTapGesture {
                            self.viewRouter.currentView = "list"
                            self.viewRouter.itemColor = "list"
                            
                        }
                        
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height/10)
                    .background(Color.white.shadow(radius: 2))
                    
                    
                    
                }
                
            }.edgesIgnoringSafeArea(.bottom)
        }
    }
}



struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage(viewRouter: ViewRouter())
    }
}
