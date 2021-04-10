//
//  UserDataRepository.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 4/7/21.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

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

//class LocalClothItemRepository: BaseClothItemRepository, ClothItemRepository, ObservableObject {
//    override init() {
//        super.init()
//        loadData()
//    }
//
//    func addClothItem(_ clothItem: ClothItem) {
//        self.clothItems.append(clothItem)
//        saveData()
//    }
//
//    func removeClothItem(_ clothItem: ClothItem) {
//        if let index = clothItems.firstIndex(where: { $0.id == clothItem.id }) {
//            clothItems.remove(at: index)
//            saveData()
//        }
//    }
//
//    func updateClothItem(_ clothItem: ClothItem) {
//        if let index = self.clothItems.firstIndex(where: { $0.id == clothItem.id } ) {
//            self.clothItems[index] = clothItem
//            saveData()
//        }
//    }
//
//    private func loadData() {
//        if let retrievedClothItems = try? Disk.retrieve("clothItems.json", from: .documents, as: [ClothItem].self) {
//            self.clothItems = retrievedClothItems
//        }
//    }
//
//    private func saveData() {
//        do {
//            try Disk.save(self.clothItems, to: .documents, as: "clothItems.json")
//        }
//        catch let error as NSError {
//            fatalError("""
//        Domain: \(error.domain)
//        Code: \(error.code)
//        Description: \(error.localizedDescription)
//        Failure Reason: \(error.localizedFailureReason ?? "")
//        Suggestions: \(error.localizedRecoverySuggestion ?? "")
//        """)
//        }
//    }
//}

class FirestoreClothItemRepository: BaseClothItemRepository, ClothItemRepository, ObservableObject {
    var db = Firestore.firestore()
    
    override init() {
        super.init()
        loadData()
    }
    
    private func loadData() {
        db.collection("clothItems").order(by: "createdTime").addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                self.clothItems = querySnapshot.documents.compactMap { document -> ClothItem? in
                    try? document.data(as: ClothItem.self)
                }
            }
        }
    }
    
    func addClothItem(_ clothItem: ClothItem) {
        print("adding new item")
        do {
            let _ = try db.collection("clothItems").addDocument(from: clothItem)
        }
        catch {
            print("There was an error while trying to save a clothItem \(error.localizedDescription).")
        }
    }
    
    func updateClothItem(_ clothItem: ClothItem) {
        if let clothItemID = clothItem.id {
            do {
                try db.collection("clothItems").document(clothItemID).setData(from: clothItem)
            }
            catch {
                print("There was an error while trying to update a clothItem \(error.localizedDescription).")
            }
        }
    }
    
    func removeClothItem(_ clothItem: ClothItem) {
        if let clothItemID = clothItem.id {
            db.collection("clothItems").document(clothItemID).delete { (error) in // (1)
                if let error = error {
                    print("Error removing document: \(error.localizedDescription)")
                }
            }
        }
    }
}
