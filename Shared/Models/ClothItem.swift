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
import SDWebImageSwiftUI

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
                let iURL: String = "images/\(String(describing: UUID())).jpg"
                let dataRef = storageRef.child(iURL)
                _ = dataRef.putData(data, metadata: nil) { (metadata, error) in
                    guard let metadata = metadata else {
                        print("error uploading image")
                        return
                    }
                    _ = metadata.size
                    dataRef.downloadURL { (url, error) in
                        if url != nil {
                        }else {
                            print("error uploading image")
                            return
                        }
                    }
                }
                self.imageURL = iURL
            }
        }
    
    func getImage() -> WebImage? {
        SDWebImageManager.defaultImageLoader = StorageImageLoader.shared
        let ref = Storage.storage().reference().child(self.imageURL)
        print(ref)
        let url = NSURL.sd_URL(with: ref)! as URL
        return WebImage(url: url)
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
