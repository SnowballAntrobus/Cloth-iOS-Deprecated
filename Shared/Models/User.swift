//
//  User.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/9/21.
//

import Foundation
import SwiftUI

struct User: Hashable {
    var id: Int
    var name: String
    var items: [Item]
    
    var imageName: String
        var image: Image {
            Image(imageName)
        }
}
