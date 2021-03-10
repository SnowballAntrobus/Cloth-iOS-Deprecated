//
//  Item.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/9/21.
//

import Foundation
import SwiftUI

struct Item: Hashable, Identifiable {
    var id: Int
    var type: String
    var color: String
    var brand: String
    
    var imageName: String
        var image: Image {
            Image(imageName)
        }
}
