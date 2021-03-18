//
//  ClothingTypeEnum.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/17/21.
//

import Foundation
import SwiftUI

enum ClothItemType: String, Equatable, CaseIterable {
    case top  = "Top"
    case bottom = "Bottom"

    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}
