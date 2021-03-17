//
//  ClothFit.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/16/21.
//

import Foundation
import SwiftUI

struct ClothFit: Identifiable, Codable {
    var id: UUID
    var items: [ClothItem]
    
    init(id: UUID = UUID(), items: [ClothItem]) {
        self.id = id
        self.items = items
    }
    
}

extension ClothFit {
    static var data: [ClothFit] {
        [
            ClothFit(items: [ClothItem.data[0], ClothItem.data[2]]),
            ClothFit(items: [ClothItem.data[1], ClothItem.data[3]]),
            ClothFit(items: [ClothItem.data[0], ClothItem.data[3]]),
            ClothFit(items: [ClothItem.data[1], ClothItem.data[2]])
        ]
    }
}
