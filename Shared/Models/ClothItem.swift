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
import SDWebImageSwiftUI

struct ClothItem: Identifiable, Codable, Equatable {
    @DocumentID var id: String?
    var type: String
    var color: String
    var brand: String
    var price: String
    var imageURL: String = ""
    @ServerTimestamp var createdTime: Timestamp?
    
    init(type: String, color: String, brand: String, price: String, image: UIImage?) {
        self.type = type
        self.color = color
        self.brand = brand
        self.price = price
        self.imageURL = setImage(image: image)
    }
    
    mutating func setImage(image: UIImage?) -> String{
        if image != nil {
            let unwrappedImage: UIImage = image!
            let image = unwrappedImage.pngData()!
            let storage = Storage.storage()
            let storageRef = storage.reference()
            let data = image
            var iURL: String = "images/\(String(describing: UUID())).jpg"
            let dataRef = storageRef.child(iURL)
            let dataGroup = DispatchGroup()
            dataGroup.enter()
            _ = dataRef.putData(data, metadata: nil) { (metadata, error) in
                guard let metadata = metadata else {
                    print("error uploading image")
                    dataGroup.leave()
                    return
                }
                _ = metadata.size
                dataRef.downloadURL { (url, error) in
                    if error != nil {
                        print("error uploading image")
                        dataGroup.leave()
                    } else {
                        print(url!.absoluteString)
                        iURL = url!.absoluteString
                        dataGroup.leave()
                    }
                }
            }
            
            dataGroup.notify(queue: .main) {
                self.imageURL = iURL
                print(self.imageURL)
            }
            return iURL
        }
        return ""
    }
    
    func getImage() -> WebImage? {
        return WebImage(url: URL(string:self.imageURL))
    }
    
}

extension ClothItem {
    static var data: [ClothItem] {
        [
            ClothItem(type: "Top", color: "pink", brand:"FYE", price: "50", image: UIImage(named: "pants")),
            ClothItem(type: "Top", color: "brown", brand:"Gucci", price: "100", image: UIImage(named: "pants")),
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
