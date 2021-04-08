//
//  ClothItem.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/16/21.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ClothItem: Identifiable, Codable, Equatable {
    @DocumentID var id: String?
    var type: String
    var color: String
    var brand: String
    var price: String
    var image: Data? = UIImage(systemName: "square.fill")?.pngData()!
    @ServerTimestamp var createdTime: Timestamp?
    
    init(type: String, color: String, brand: String, price: String, image: UIImage?) {
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
            ClothItem(type: "Top", color: "pink", brand:"FYE", price: "50", image: UIImage(named: "top")),
            ClothItem(type: "Top", color: "brown", brand:"Gucci", price: "100", image: UIImage(named: "top")),
            ClothItem(type: "Bottom", color: "green", brand:"pong", price: "500", image: UIImage(named: "pants")),
            ClothItem(type: "Bottom", color: "yellow", brand:"AWL", price: "20", image: UIImage(named: "pants"))
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
