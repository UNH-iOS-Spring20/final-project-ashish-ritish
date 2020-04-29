//
//  CustomPicker.swift
//  MarketPlace
//
//  Created by ritish karki on 4/28/20.
//  Copyright © 2020 Ashish-Ritish. All rights reserved.
//

import SwiftUI
import Photos

struct CustomPicker : View {
    
    @Binding var selected : [UIImage]
    @State var data : [Images] = []
    @State var grid : [Int] = []
    @Binding var show : Bool
    @State var disabled = false
    
    var body: some View{
        let chunkedImages = data.chunked(into: 3)
        return GeometryReader{ geo in
            
            VStack{
                if !self.grid.isEmpty{
                    HStack{

                        Text("Pick a Image")
                            .fontWeight(.bold)

                        Spacer()
                    }
                    .padding(.leading)
                    .padding(.top)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 20){
                            ForEach(0..<chunkedImages.count, id: \.self) { index in
                                HStack(spacing:10) {
                                    ForEach(chunkedImages[index], id: \.self) { image in
                                        return Card(data: image,selected: self.$selected)
                                    }
                                }
                            }
                        }
                    }
                    
                    Button(action: {
                        self.show.toggle()
                    }) {

                        Text("Select")
                            .foregroundColor(.white)
                            .padding(.vertical,10)
                            .frame(width: UIScreen.main.bounds.width / 2)
                    }
                    .background(Color("appBlue").opacity((self.selected.count != 0) ? 1 : 0.5))
                    .clipShape(Capsule())
                    .padding(.bottom, 25)
                    .disabled((self.selected.count != 0) ? false : true)

                }else{
                    if self.disabled{
                    
                        Text("Enable Storage Access In Settings !!!")
                    }
                    else{

                        Indicator()
                    }
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .background(Color.white)
            .cornerRadius(12)
        }
        .background(Color.black.opacity(0.1).edgesIgnoringSafeArea(.all)
        .onTapGesture {
            self.show.toggle()
        })
        .onAppear {
            self.getPhotoLibraryAccessAuthorisation()
        }
    }
    
    func getPhotoLibraryAccessAuthorisation() {
        PHPhotoLibrary.requestAuthorization { (status) in
            
            if status == .authorized{
                
                self.getAllImages()
                self.disabled = false
            }
            else{
                
                print("not authorized")
                self.disabled = true
            }
        }
    }
    
    func getAllImages(){
        
        let req = PHAsset.fetchAssets(with: .image, options: .none)
        
        DispatchQueue.global(qos: .background).async {
            
            req.enumerateObjects { (asset, _, _) in
                
                let options = PHImageRequestOptions()
                options.isSynchronous = true
                
                PHCachingImageManager.default().requestImage(for: asset, targetSize: .init(), contentMode: .default, options: options) { (image, _) in
                    
                    let data1 = Images(image: image!, selected: false)
                    
                    self.data.append(data1)
                }
            }
            
            if req.count == self.data.count{
                
                self.getGrid()
            }
        }
    }
    
    func getGrid(){
        
        for i in stride(from: 0, to: self.data.count, by: 3){
            
            self.grid.append(i)
        }
    }
}

struct Images: Hashable {
    var image: UIImage
    var selected: Bool
}

struct Card : View {
    
    @State var data : Images
    @Binding var selected : [UIImage]
    
    var body: some View{
        
        ZStack{
            
            Image(uiImage: self.data.image)
            .resizable()
            
            if self.data.selected{
                
                ZStack{
                    
                    Color.black.opacity(0.5)
                    
                    Image(systemName: "checkmark")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                }
            }
            
        }
        .frame(width: (UIScreen.main.bounds.width - 80) / 3, height: 90)
        .onTapGesture {
        
            if !self.data.selected{
                
                self.data.selected = true
                
                self.selected.append(self.data.image)
            }
            else{
                
                for i in 0..<self.selected.count{
                    
                    if self.selected[i] == self.data.image{
                        
                        self.selected.remove(at: i)
                        self.data.selected = false
                        return
                    }
                }
            }
            
        }
        
    }
}
