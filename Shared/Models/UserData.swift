//
//  UserData.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/16/21.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

class UserData: Codable {
    @DocumentID var id: String?
    var name: String = "Celery Coble"
    var imageName: String = "UserImage"
        var image: Image {
            Image(imageName)
        }
    var triedClothFits: [ClothFit] = []
    @ServerTimestamp var createdTime: Timestamp?
    var userId: String?
    
    init(name: String, imageName: String, triedClothFits: [ClothFit]){
        self.name = name
        self.imageName = imageName
        self.triedClothFits = triedClothFits
    }
}



extension UserData {
    static var data: [UserData] {
        [
            UserData(name:"Dante Gil-Marin", imageName: "UserImage", triedClothFits: [])
        ]
    }
}
