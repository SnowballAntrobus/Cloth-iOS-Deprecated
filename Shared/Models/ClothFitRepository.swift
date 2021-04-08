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

protocol ClothFitRepository: BaseClothFitRepository {
  func addClothFit(_ clothFit: ClothFit)
  func removeClothFit(_ clothFit: ClothFit)
  func updateClothFit(_ clothFit: ClothFit)
}

class TestDataClothFitRepository: BaseClothFitRepository, ClothFitRepository, ObservableObject {
  override init() {
    super.init()
    self.clothFits = ClothFit.data
  }
  
  func addClothFit(_ clothFit: ClothFit) {
    clothFits.append(clothFit)
  }
  
  func removeClothFit(_ clothFit: ClothFit) {
    if let index = clothFits.firstIndex(where: { $0.id == clothFit.id }) {
      clothFits.remove(at: index)
    }
  }
  
  func updateClothFit(_ clothFit: ClothFit) {
    if let index = self.clothFits.firstIndex(where: { $0.id == clothFit.id } ) {
      self.clothFits[index] = clothFit
    }
  }
}
