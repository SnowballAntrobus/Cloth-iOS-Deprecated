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
import FirebaseStorage
import FirebaseUI

struct ClothItem: Identifiable, Codable, Equatable {
    @DocumentID var id: String?
    var type: String
    var color: String
    var brand: String
    var price: String
    var imageURL: String = ""
    @ServerTimestamp var createdTime: Timestamp?
    
    init(type: String, color: String, brand: String, price: String) {
        self.type = type
        self.color = color
        self.brand = brand
        self.price = price
    }
    
    mutating func setImage(image: UIImage?) {
        if image != nil {
            let unwrappedImage: UIImage = image!
            let image = unwrappedImage.pngData()!
            let storage = Storage.storage()
            let storageRef = storage.reference()
            let data = image
            let dataRef = storageRef.child("images/\(self.id ?? "error").png")
            var iURL: URL? = nil
            _ = dataRef.putData(data, metadata: nil) { (metadata, error) in
                print("HERE")
                guard let metadata = metadata else {
                    print("error uploading image")
                    return
                }
                _ = metadata.size
                dataRef.downloadURL { (url, error) in
                    if url != nil {
                        iURL = url!
                    }else {
                        print("error uploading image")
                        return
                    }
                }
            }
            if iURL != nil {
                self.imageURL = iURL!.absoluteString
            }
            else {
                self.imageURL = ""
            }
        } else {
            self.imageURL = ""
        }
    }
    
    func getImage() -> UIImage? {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let reference = storageRef.child(self.imageURL)
        let placeholderImage = UIImage(named: "pants.jpg")
        let imageView: UIImageView = UIImageView(image: placeholderImage)
        imageView.sd_setImage(with: reference, placeholderImage: placeholderImage)
        return imageView.image
    }
    
}

extension ClothItem {
    static var data: [ClothItem] {
        [
            ClothItem(type: "Top", color: "pink", brand:"FYE", price: "50"),
            ClothItem(type: "Top", color: "brown", brand:"Gucci", price: "100"),
            ClothItem(type: "Bottom", color: "green", brand:"pong", price: "500"),
            ClothItem(type: "Bottom", color: "yellow", brand:"AWL", price: "20")
        ]
    }
}

extension ClothItem {
    struct Datas {
        var type: ClothItemType = .top
        var color: String = ""
        var brand: String = ""
        var price: String = ""
    }
    
    var data: Datas {
        return Datas(type: ClothItemType(rawValue: type) ?? ClothItemType(rawValue: "Top")!, color: color, brand: brand, price: price)
    }
    
    mutating func update(from data: Datas) {
        type = data.type.id
        color = data.color
        brand = data.brand
        price = data.price
    }
}
