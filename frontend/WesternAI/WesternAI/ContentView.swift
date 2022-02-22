//
//  ContentView.swift
//  Western AI App
//
//  Created by Keerthen Ravichandran on 2022-02-08.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        ZStack {
            Color(red: 217/255, green: 235/255, blue: 255/255)
                .edgesIgnoringSafeArea(.all)
            Button(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/) {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
            }
        }
        
        ZStack {
            
          
            Color(red: 217/255, green: 235/255, blue: 255/255)
                            .edgesIgnoringSafeArea(.all)
            Image("CameraLogo")
                .resizable()
                .scaledToFit().position(x: 40, y:720).frame(width:295)
            
            Button("Camera Button ") {
                
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
            }.position(x: 90, y: 720)
            
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
            

            
            /*.frame(width:220,height: 220)*/
        }
        
            
           
        
        
    }
    
   
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
.previewInterfaceOrientation(.portrait)
        
    }
}
