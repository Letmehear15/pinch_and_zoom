//
//  InfoPanelView.swift
//  pinchAndZoom
//
//  Created by Aleksandr Nesterov on 02.09.2024.
//

import SwiftUI

struct InfoPanelView: View {
    
    @State private var isInfoPanelVisible = false
    
     var scale: CGFloat
     var offSet: CGSize
    
    func withThreeSymbolsAfterComma(number: CGFloat) -> String {
        return(String(format:"%.3f", number))
    }
    
    var body: some View {
        HStack(spacing: 15){
            Image(systemName: "circle.circle")
                .symbolRenderingMode(.hierarchical)
                .resizable()
                .frame(width: 30, height: 30)
                .onLongPressGesture(minimumDuration: 1, perform: {
                    withAnimation(.easeIn, {
                        isInfoPanelVisible.toggle()
                    })
                })
            
            HStack(spacing: 2){
                Image(systemName:"arrow.up.left.and.arrow.down.right")
                Text("\(withThreeSymbolsAfterComma(number: scale))")
                
                Spacer()
                
                Image(systemName:"arrow.left.and.right")
                Text("\(withThreeSymbolsAfterComma(number: offSet.width))")
                
                Spacer()
                
                Image(systemName:"arrow.up.and.down")
                Text("\(withThreeSymbolsAfterComma(number: offSet.height))")
                
                Spacer()
            }
            .font(.footnote)
            .padding(8)
            .background(.ultraThinMaterial)
            .opacity(isInfoPanelVisible ? 1 : 0)
            .cornerRadius(10)
            .frame(maxWidth: 420)
        }
        .padding()
        
        
        
        Spacer()
    }
}

#Preview {
    InfoPanelView(
        scale: 1, offSet: .zero
    )
    .previewLayout(.sizeThatFits)
    .preferredColorScheme(.dark)
}
