//
//  UserDataRepository.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 4/7/21.
//

import Foundation

class BaseClothItemRepository {
  @Published var clothItems = [ClothItem]()
}

protocol ClothItemRepository: BaseClothItemRepository {
  func addClothItem(_ ClothItem: ClothItem)
  func removeClothItem(_ ClothItem: ClothItem)
  func updateClothItem(_ ClothItem: ClothItem)
}

class TestDataClothItemRepository: BaseClothItemRepository, ClothItemRepository, ObservableObject {
  override init() {
    super.init()
    self.clothItems = ClothItem.data
  }
  
  func addClothItem(_ clothItem: ClothItem) {
    clothItems.append(clothItem)
  }
  
  func removeClothItem(_ clothItem: ClothItem) {
    if let index = clothItems.firstIndex(where: { $0.id == clothItem.id }) {
      clothItems.remove(at: index)
    }
  }
  
  func updateClothItem(_ clothItem: ClothItem) {
    if let index = self.clothItems.firstIndex(where: { $0.id == clothItem.id } ) {
      self.clothItems[index] = clothItem
    }
  }
}
