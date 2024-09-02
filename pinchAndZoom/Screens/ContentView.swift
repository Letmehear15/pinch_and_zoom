//
//  ContentView.swift
//  pinchAndZoom
//
//  Created by Aleksandr Nesterov on 01.09.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isAnimating = false
    @State private var scaledLevel: CGFloat = 1
    @State private var imageOffset: CGSize = .zero
    
    let deviceMaxWidth = UIScreen.main.bounds.size.width - 60
    let deviceMaxHeight = UIScreen.main.bounds.size.height
    
    func onChanged (_ value: DragGesture.Value) {
        withAnimation(.smooth){
            if abs(value.translation.width) <= deviceMaxWidth / 1.5 && abs(value.translation.height) <= deviceMaxHeight / 2 {
                imageOffset = value.translation
            }
        }
    }
    
    func onEnded() {
        withAnimation(.smooth) {
            if scaledLevel == 1 && (abs(imageOffset.width) > 0 ||  abs(imageOffset.height) > 0) {
                resetImageOffset()
            }
        }
    }
    
    func resetImageOffset() {
        scaledLevel = 1
        imageOffset = .zero
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.7), radius: 10, x: 2, y: 2)
                    .offset(imageOffset)
                    .scaleEffect(scaledLevel)
                    .opacity(isAnimating ? 1 : 0)
                    .padding()
                    .onTapGesture(count: 2, perform: {
                        withAnimation(.smooth(duration: 0.5)){
                            if scaledLevel == 5 {
                                resetImageOffset()
                            } else {
                                scaledLevel = 5
                            }
                        }
                    })
                    .gesture(
                        DragGesture()
                        .onChanged({value in
                            onChanged(value)
                        })
                        
                        .onEnded({_ in
                            onEnded()
                        })
                    )
                
                
            }
            .navigationBarTitle("Pinch and zoom.", displayMode: .inline)
            .onAppear(perform: {
                withAnimation(.spring(duration: 0.7)) {
                    isAnimating.toggle()
                }
            })
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    ContentView()
}
