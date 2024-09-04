//
//  ControlIcon.swift
//  pinchAndZoom
//
//  Created by Aleksandr Nesterov on 02.09.2024.
//

import SwiftUI

struct ControlIcon: View {
    let imageName: String
    
    var body: some View {
        Image(systemName: imageName)
            .font(.system(size: 30))
    }
}

#Preview {
    ControlIcon(imageName: "plus.magnifyingglass")
}
