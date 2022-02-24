//
// ContentView.swift
//  Western AI App
//https://www.pinterest.ca/pin/799529740090720623/
//  Created by Keerthen Ravichandran on 2022-02-08.
/*https://www.vectorstock.com/royalty-free-vector/picture-icon-image-symbol-vector-20419048*/
//https://www.123rf.com/photo_139509263_stock-vector-blue-line-trash-can-icon-isolated-on-blue-background-garbage-bin-sign-recycle-basket-icon-office-tra.html

import SwiftUI

struct ContentView: View {
    @State private var isShowPhotoLibrary=false
    @State private var image = UIImage()
    
    var body: some View {
        
        
        ZStack {
            
            Color(red: 217/255, green: 235/255, blue: 255/255)
                .edgesIgnoringSafeArea(.all)
            Image("CameraLogo")
                .resizable()
                .scaledToFit().position(x: 40, y:720).frame(width:295)
            
            
            Text("Eco Force")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding([.top, .trailing]).position(x: 200, y:80)
            
            Image("ClosedTrashCan")
                .resizable()
                .scaledToFit()
            
            Text("Take photo or upload photo to scan")
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding([.top, .trailing]).position(x:200, y:610)
            
            
            Image("Photo")
                .resizable()
                .scaledToFit().position(x: 150, y:720).frame(width:70)
            
           
            
           /* Button("    Camera     ") {
                self.isShowPhotoLibrary = true
            }.position(x: 90, y: 720)
        .sheet(isPresented: $isShowPhotoLibrary){
            CameraPicker(sourceType: .camera, selectedImage: self.$image)
        }*/
            Button("                ") {
                 self.isShowPhotoLibrary = true
             }.position(x: 300, y: 720)
         .sheet(isPresented: $isShowPhotoLibrary){
             ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
         }
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
}
