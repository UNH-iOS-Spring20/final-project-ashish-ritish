//
//  Demo.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 4/15/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI

struct Demo: View {
    @State var selected = ""
    @State var show = false

    var body: some View {
        
        
        
        ZStack{
            
            VStack(alignment: .leading) {
                                  Text("Product Category").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                                  HStack {
                                      TextField("Product Category", text: $selected)
                                      Button(action: {
                                          
                                          
                                          self.show.toggle()
                                      }){
                                          Image(systemName: "chevron.down")
                                      }
                                  }
                                  
                              }
                              
                              VStack{
                                  Spacer()
                                  RadioButtons(selected: self.$selected, show: self.$show).offset(y: self.show ? (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 15: UIScreen.main.bounds.height)
                              }.background(Color(UIColor.label.withAlphaComponent(self.show ? 0.2 : 0)).edgesIgnoringSafeArea(.all))
           
        
                
          
        }.background(Color.white.edgesIgnoringSafeArea(.all))
            .animation(.default)

    }
}

struct Demo_Previews: PreviewProvider {
    static var previews: some View {
        Demo()
    }
}

