//
//  RadioButtons.swift
//  MarketPlace
//
//  Created by Ashish-Ritish on 4/15/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.


import SwiftUI
 
struct RadioButtons : View {
    
    @Binding var selected : String
    @Binding var show : Bool
    var data = [String]()
    
    var body : some View{
        VStack(alignment: .leading, spacing: 15) {
            
            ForEach(data,id: \.self) { i in
                
                Button(action: {
                    
                    self.selected = i
                       self.show.toggle()
                    
                }) {
                    
                    HStack{
                        
                        Text(i).font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                        
                        Spacer()
                        
                        ZStack {
                            Circle().fill(self.selected == i ? Color("appBlue") : Color.black.opacity(0.2)).frame(width: 18, height: 18)
                            
                            if self.selected == i {
                                Circle().stroke(Color("appBlue"), lineWidth: 4).frame(width: 25, height: 25)
                            }
                        }
                        
                    }.foregroundColor(.black)
                    
                }.padding(.top)
            }
            
            
        }.padding(.vertical)
            .padding(.horizontal,25)
            .padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 30)
            .background(Color.white)
            .cornerRadius(30)
    }
}

