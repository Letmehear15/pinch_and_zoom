//
//  SideDrawerView.swift
//  pinchAndZoom
//
//  Created by Aleksandr Nesterov on 04.09.2024.
//

import SwiftUI

struct SideDrawerView: View {
    var body: some View {
        HStack(spacing: 20){
            Image(systemName: "chevron.left")
                .resizable()
                .scaledToFit()
                .frame(height: 40)
                .padding(8)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 40)
        .padding(.horizontal)
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .frame(width: 260)
    }
}

#Preview {
    SideDrawerView()
//        .preferredColorScheme(.dark)
}
