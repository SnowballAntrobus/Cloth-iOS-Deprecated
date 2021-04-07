//
//  UserPreferences.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 4/7/21.
//

import Foundation
import RealmSwift

class UserPreferences: EmbeddedObject {
   @objc dynamic var displayName: String?
   @objc dynamic var avatarImage: Photo?
}
