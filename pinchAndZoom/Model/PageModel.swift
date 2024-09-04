//
//  PageModel.swift
//  pinchAndZoom
//
//  Created by Aleksandr Nesterov on 04.09.2024.
//

import Foundation


struct Page: Identifiable {
    let id: Int
    let imageName: String
}

extension Page {
    var thumbImageName: String {
        return "thumb-\(imageName)"
    }
}
