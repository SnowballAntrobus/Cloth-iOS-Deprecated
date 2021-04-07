//
//  Photo.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 4/7/21.
//

import Foundation
import RealmSwift

class Photo: EmbeddedObject {
   @objc dynamic var _id = UUID().uuidString
   @objc dynamic var thumbNail: Data?
   @objc dynamic var picture: Data?
   @objc dynamic var date = Date()
}
