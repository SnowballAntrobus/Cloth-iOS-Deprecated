//
//  UserDataRepository.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 4/7/21.
//

import Foundation
import Disk

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

class LocalClothItemRepository: BaseClothItemRepository, ClothItemRepository, ObservableObject {
  override init() {
    super.init()
    loadData()
  }
  
  func addClothItem(_ clothItem: ClothItem) {
    self.clothItems.append(clothItem)
    saveData()
  }
  
  func removeClothItem(_ clothItem: ClothItem) {
    if let index = clothItems.firstIndex(where: { $0.id == clothItem.id }) {
      clothItems.remove(at: index)
      saveData()
    }
  }
  
  func updateClothItem(_ clothItem: ClothItem) {
    if let index = self.clothItems.firstIndex(where: { $0.id == clothItem.id } ) {
      self.clothItems[index] = clothItem
      saveData()
    }
  }
  
  private func loadData() {
    if let retrievedClothItems = try? Disk.retrieve("clothItems.json", from: .documents, as: [ClothItem].self) {
      self.clothItems = retrievedClothItems
    }
  }
  
  private func saveData() {
    do {
      try Disk.save(self.clothItems, to: .documents, as: "clothItems.json")
    }
    catch let error as NSError {
      fatalError("""
        Domain: \(error.domain)
        Code: \(error.code)
        Description: \(error.localizedDescription)
        Failure Reason: \(error.localizedFailureReason ?? "")
        Suggestions: \(error.localizedRecoverySuggestion ?? "")
        """)
    }
  }
}
