//
//  ClothItem.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/16/21.
//

import Foundation
import SwiftUI

struct ClothItem: Identifiable, Codable {
    var id: UUID
    var type: String
    var color: String
    var brand: String
    var price: String
    var imageName: String
        var image: Image {
            Image(imageName)
        }
    
    init(id: UUID = UUID(), type: String, color: String, brand: String, price: String, imageName: String) {
        self.id = id
        self.type = type
        self.color = color
        self.brand = brand
        self.price = price
        self.imageName = imageName
    }
    
}

extension ClothItem {
    static var data: [ClothItem] {
        [
            ClothItem(type: "top", color: "pink", brand:"FYE", price: "50", imageName: "UserImage"),
            ClothItem(type: "top", color: "brown", brand:"Gucci", price: "100", imageName: "UserImage"),
            ClothItem(type: "bottom", color: "green", brand:"pong", price: "500", imageName: "UserImage"),
            ClothItem(type: "bottom", color: "yellow", brand:"AWL", price: "20", imageName: "UserImage")
        ]
    }
}

extension ClothItem {
    struct Data {
        var type: String = ""
        var color: String = ""
        var brand: String = ""
        var price: String = ""
        var imageName: String = "UserImage"
    }

    var data: Data {
        return Data(type: type, color: color, brand: brand, price: price, imageName: imageName)
    }
    
    mutating func update(from data: Data) {
        type = data.type
        color = data.color
        brand = data.brand
        price = data.price
        }
}
