//
//  ClothFitRepository.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 4/7/21.
//

import Foundation

class BaseClothFitRepository {
  @Published var clothFits = [ClothFit]()
}

protocol clothFitRepository: BaseClothFitRepository {
  func addClothItem(_ clothFit: ClothFit)
  func removeClothItem(_ clothFit: ClothFit)
  func updateClothItem(_ clothFit: ClothFit)
}

class TestDataClothFitRepository: BaseClothFitRepository, clothFitRepository, ObservableObject {
  override init() {
    super.init()
    self.clothFits = ClothFit.data
  }
  
  func addClothItem(_ clothFit: ClothFit) {
    clothFits.append(clothFit)
  }
  
  func removeClothItem(_ clothFit: ClothFit) {
    if let index = clothFits.firstIndex(where: { $0.id == clothFit.id }) {
      clothFits.remove(at: index)
    }
  }
  
  func updateClothItem(_ clothFit: ClothFit) {
    if let index = self.clothFits.firstIndex(where: { $0.id == clothFit.id } ) {
      self.clothFits[index] = clothFit
    }
  }
}
