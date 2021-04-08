//
//  ClothFitRepository.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 4/7/21.
//

import Foundation
import Disk
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

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

class LocalClothFitRepository: BaseClothFitRepository, ClothFitRepository, ObservableObject {
  override init() {
    super.init()
    loadData()
  }
  
  func addClothFit(_ clothFit: ClothFit) {
    self.clothFits.append(clothFit)
    saveData()
  }
  
  func removeClothFit(_ clothFit: ClothFit) {
    if let index = clothFits.firstIndex(where: { $0.id == clothFit.id }) {
      clothFits.remove(at: index)
      saveData()
    }
  }
  
  func updateClothFit(_ clothFit: ClothFit) {
    if let index = self.clothFits.firstIndex(where: { $0.id == clothFit.id } ) {
      self.clothFits[index] = clothFit
      saveData()
    }
  }
  
  private func loadData() {
    if let retrievedClothFits = try? Disk.retrieve("clothFits.json", from: .documents, as: [ClothFit].self) {
      self.clothFits = retrievedClothFits
    }
  }
  
  private func saveData() {
    do {
      try Disk.save(self.clothFits, to: .documents, as: "clothFits.json")
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

class FirestoreClothFitRepository: BaseClothFitRepository, ClothFitRepository, ObservableObject {
    var db = Firestore.firestore() // (1)
    
    override init() {
        super.init()
        loadData()
    }
    
    private func loadData() {
        db.collection("clothFits").order(by: "createdTime").addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                self.clothFits = querySnapshot.documents.compactMap { document -> ClothFit? in
                    try? document.data(as: ClothFit.self)
                }
            }
        }
    }
    
    func addClothFit(_ clothFit: ClothFit) {
        do {
            let _ = try db.collection("clothFits").addDocument(from: clothFit)
        }
        catch {
            print("There was an error while trying to save a clothFit \(error.localizedDescription).")
        }
    }
    
    func updateClothFit(_ clothFit: ClothFit) {
        if let clothFitID = clothFit.id {
            do {
                try db.collection("clothFits").document(clothFitID).setData(from: clothFit)
            }
            catch {
                print("There was an error while trying to update a clothFit \(error.localizedDescription).")
            }
        }
    }
    
    func removeClothFit(_ clothFit: ClothFit) {
        if let clothFitID = clothFit.id {
            db.collection("clothFits").document(clothFitID).delete { (error) in // (1)
                if let error = error {
                    print("Error removing document: \(error.localizedDescription)")
                }
            }
        }
    }
}

