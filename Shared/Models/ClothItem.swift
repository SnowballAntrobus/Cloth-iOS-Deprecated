//
//  ClothItem.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/16/21.
//

import Foundation
import SwiftUI

struct ClothItem: Identifiable, Codable, Equatable {
    var id: UUID
    var type: String
    var color: String
    var brand: String
    var price: String
    var image: Data? = UIImage(systemName: "square.fill")?.pngData()!
    
    init(id: UUID = UUID(), type: String, color: String, brand: String, price: String, image: UIImage?) {
        self.id = id
        self.type = type
        self.color = color
        self.brand = brand
        self.price = price
        if image != nil {
            let unwrappedImage: UIImage = image!
            self.image = unwrappedImage.pngData()!
        } else {
            self.image = UIImage(systemName: "square.fill")?.pngData()!
        }
    }
    
}

extension ClothItem {
    static var data: [ClothItem] {
        [
            ClothItem(type: "Top", color: "pink", brand:"FYE", price: "50", image: nil),
            ClothItem(type: "Top", color: "brown", brand:"Gucci", price: "100", image: nil),
            ClothItem(type: "Bottom", color: "green", brand:"pong", price: "500", image: nil),
            ClothItem(type: "Bottom", color: "yellow", brand:"AWL", price: "20", image: nil)
        ]
    }
}

extension ClothItem {
    struct Datas {
        var type: ClothItemType = .top
        var color: String = ""
        var brand: String = ""
        var price: String = ""
        var image: Data? = UIImage(systemName: "square.fill")?.pngData()!
    }

    var data: Datas {
        return Datas(type: ClothItemType(rawValue: type) ?? ClothItemType(rawValue: "Top")!, color: color, brand: brand, price: price, image: image)
    }
    
    mutating func update(from data: Datas) {
        type = data.type.id
        color = data.color
        brand = data.brand
        price = data.price
        image = data.image
        }
}
