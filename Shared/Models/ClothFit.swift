//
//  ClothFit.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/16/21.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ClothFit: Identifiable, Codable {
    @DocumentID var id: String?
    var items: [String]
    var star: Bool = false
    var use: Int = 0
    var price: String = "0"
    @ServerTimestamp var createdTime: Timestamp?
    
    init(items: [String], star: Bool) {
        self.items = items
        self.star = star
    }
}

extension ClothFit: Equatable {
    static func == (lhs: ClothFit, rhs: ClothFit) -> Bool {
        for id in lhs.items {
            if !rhs.items.contains(id) {
                return false
            }
        }
        return true
    }
}

extension ClothFit {
    static var data: [ClothFit] {
        [
            ClothFit(items: [ClothItem.data[0].id!, ClothItem.data[2].id!], star: false),
            ClothFit(items: [ClothItem.data[1].id!, ClothItem.data[3].id!], star: false),
            ClothFit(items: [ClothItem.data[0].id!, ClothItem.data[3].id!], star: false),
            ClothFit(items: [ClothItem.data[1].id!, ClothItem.data[2].id!], star: false)
        ]
    }
}
