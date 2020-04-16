//
//  RadioButton.swift
//  MarketPlace
//
//  Created by Ashish Shrestha on 4/15/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI

struct RadioButton: View {
    
    var categorys = ["Auto Motive", "Cell Phone", "Computer", "Electronics", "Fashion", "Household", "Music", "Real Estate", "Rental", "Sports", "Stationery", "Others"]
    
    @Binding var selected : String
    @Binding var show : Bool
    
    var body : some View {
        
        VStack(alignment: .leading, spacing: 20) {
            
            
            ForEach(categorys, id: .self){ category in
                
                Button(action: {
                    
                    self.selected = category
                    
                }) {
                    
                    HStack{
                        
                        Text(category)
                        
                        Spacer()
                        
                        ZStack{
                            
                            Circle().fill(self.selected == category ? Color(.gray) : Color.black.opacity(0.2)).frame(width: 18, height: 18)
                            
                            if self.selected == category {
                                
                                Circle().stroke(Color("appBlue"), lineWidth: 4).frame(width: 25, height: 25)
                            }
                        }
                        
                        
                        
                    }.foregroundColor(.black)
                    
                }.padding(.top)
            }
            
            HStack{
                
                Spacer()
                
                Button(action: {
                    
                    self.show.toggle()
                    
                }) {
                    
                    Text("Selet").padding(.vertical).padding(.horizontal,25).foregroundColor(.white)
                    
                }
                .background(
                    
                    self.selected != "" ?
                        
                        LinearGradient(gradient: .init(colors: [Color("appBlue"),Color("appBlue")]), startPoint: .leading, endPoint: .trailing) :
                        
                        LinearGradient(gradient: .init(colors: [Color.black.opacity(0.2),Color.black.opacity(0.2)]), startPoint: .leading, endPoint: .trailing)
                    
                )
                    .clipShape(Capsule())
                    .disabled(self.selected != "" ? false : true)
                
                
            }.padding(.top)
            
        }.padding(.vertical)
            .padding(.horizontal,25)
            .padding(.bottom,(UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 15)
            .background(Color.white)
            .cornerRadius(30)
    }
}


//struct RadioButton_Previews: PreviewProvider {
//    static var previews: some View {
//        RadioButton(selected: , show: .constant(false))
//    }
//}
