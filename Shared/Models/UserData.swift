//
//  UserData.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/16/21.
//

import Foundation
import SwiftUI

class UserData: ObservableObject {
    var name: String = "Celery Coble"
    var imageName: String = "UserImage"
        var image: Image {
            Image(imageName)
        }
    
    init(name: String, imageName: String){
        self.name = name
        self.imageName = imageName
    }
}



extension UserData {
    static var data: [UserData] {
        [
            UserData(name:"Dante Gil-Marin", imageName: "UserImage")
        ]
    }
}
