//
//  User.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/9/21.
//

import Foundation
import RealmSwift

import Foundation
import RealmSwift

@objcMembers class User: Object, ObjectKeyIdentifiable {
    dynamic var _id = UUID().uuidString
    dynamic var partition = "" // "user=_id"
    dynamic var userName = ""
    dynamic var userPreferences: UserPreferences?
    dynamic var lastSeenAt: Date?
    var userData = UserData.data[0]
    var clothFits = List<ClothFit>() //var conversations = List<Conversation>()
    dynamic var presence = "Off-Line"
    
    override static func primaryKey() -> String? {
        return "_id"
    }
}
