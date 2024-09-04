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
    @State private var lastScale: CGFloat = 1
    @State private var imageOffset: CGSize = .zero
    @State private var isSideDrawerOpen = false
    @State private var chevronIcon = "chevron.compact.left"
    
    let deviceMaxWidth = UIScreen.main.bounds.size.width - 60
    let deviceMaxHeight = UIScreen.main.bounds.size.height
    let maxScaledLevel: CGFloat = 5
    
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
                Color.clear
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
                            if scaledLevel == 1 {
                                scaledLevel = maxScaledLevel
                                lastScale = maxScaledLevel
                            } else {
                                resetImageOffset()
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
                    .gesture(
                        MagnificationGesture()
                            .onChanged({ value in
                                withAnimation(.smooth) {
                                    if scaledLevel <= maxScaledLevel + 5 {
                                        scaledLevel = value * lastScale
                                    }
                                }
                            })
                        
                            .onEnded({_ in
                                withAnimation(.smooth) {
                                    lastScale = scaledLevel
                                    
                                    if scaledLevel >= maxScaledLevel {
                                        scaledLevel = maxScaledLevel
                                        lastScale = maxScaledLevel
                                    } else if scaledLevel <= 1 {
                                        resetImageOffset()
                                        lastScale = 1
                                    }
                                }
                                
                            })
                        
                    )
            }
            .navigationBarTitle("Pinch and zoom.", displayMode: .inline)
            .onAppear(perform: {
                withAnimation(.spring(duration: 0.7)) {
                    isAnimating.toggle()
                }
            })
            .overlay(alignment: .top, content: {
                InfoPanelView(scale: scaledLevel, offSet: imageOffset)
            })
            .overlay(alignment: .bottom, content: {
                Group{
                    HStack(spacing: 20){
                        Button(action:{
                            withAnimation(.smooth) {
                                if scaledLevel > 1 {
                                    scaledLevel -= 1
                                    lastScale -= 1
                                }
                            }
                        }, label: {
                            ControlIcon(imageName: "minus.magnifyingglass")
                        })
                        
                        Button(action: {
                            withAnimation(.smooth) {
                                scaledLevel = 1
                                lastScale = 1
                                imageOffset = .zero
                            }
                        }, label: {
                            ControlIcon(imageName: "arrow.up.left.and.down.right.magnifyingglass")
                        })
                        
                        Button(action: {
                            withAnimation(.smooth){
                                if scaledLevel < maxScaledLevel {
                                    scaledLevel += 1
                                    lastScale += 1
                                }
                            }
                        }) {
                            ControlIcon(imageName: "plus.magnifyingglass")
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.vertical, 15)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                }
            })
            .overlay(alignment: .topTrailing) {
                HStack{
                    Image(systemName: chevronIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                        .padding(8)
                        .foregroundColor(.secondary)
                        .onTapGesture(perform: {
                            chevronIcon = isSideDrawerOpen ? "chevron.compact.left" : "chevron.compact.right"
                            withAnimation(.smooth(duration: 0.5)) {
                                isSideDrawerOpen.toggle()
                            }
                        })

                    Spacer()
                }
                .padding(.vertical, 20)
                .padding(.horizontal)
                .background(.ultraThinMaterial)
                .opacity(isAnimating ? 1 : 0)
                .cornerRadius(20)
                .offset(x: isSideDrawerOpen ? 20 : 215, y: UIScreen.main.bounds.height / 12)
                .frame(width: 260)
            }
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    ContentView()
}
