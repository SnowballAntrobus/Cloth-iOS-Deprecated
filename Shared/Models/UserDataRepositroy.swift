//
//  UserDataRepositroy.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 4/7/21.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import Resolver
import Combine

class BaseUserDataRepository {
    @Published var userDatas = [UserData]()
}

protocol UserDataRepository: BaseUserDataRepository {
    func addUserData(_ userData: UserData)
    func removeUserData(_ userData: UserData)
    func updateUserData(_ userData: UserData)
}

class TestDataUserDataRepository: BaseUserDataRepository, UserDataRepository, ObservableObject {
    override init() {
        super.init()
        self.userDatas = UserData.data
    }
    
    func addUserData(_ userData: UserData) {
        userDatas.append(userData)
    }
    
    func removeUserData(_ userData: UserData) {
        if let index = userDatas.firstIndex(where: { $0.id == userData.id }) {
            userDatas.remove(at: index)
        }
    }
    
    func updateUserData(_ userData: UserData) {
        if let index = self.userDatas.firstIndex(where: { $0.id == userData.id } ) {
            self.userDatas[index] = userData
        }
    }
}

class FirestoreUserDataRepository: BaseUserDataRepository, UserDataRepository, ObservableObject {
    var db = Firestore.firestore()
    
    @Injected var authenticationService: AuthenticationService // (1)
    var userDatasPath: String = "userDatas" // (2)
    var userId: String = "unknown"
    
    private var cancellables = Set<AnyCancellable>()
    
    override init() {
        super.init()
        
        authenticationService.$user // (3)
            .compactMap { user in
                user?.uid // (4)
            }
            .assign(to: \.userId, on: self) // (5)
            .store(in: &cancellables)
        
        // (re)load data if user changes
        authenticationService.$user // (6)
            .receive(on: DispatchQueue.main) // (7)
            .sink { user in
                self.loadData() // (8)
            }
            .store(in: &cancellables)
    }
    
    private func loadData() {
        db.collection(userDatasPath)
            .whereField("userId", isEqualTo: self.userId) // (9)
            .order(by: "createdTime")
            .addSnapshotListener { (querySnapshot, error) in
                if let querySnapshot = querySnapshot {
                    self.userDatas = querySnapshot.documents.compactMap { document -> UserData? in
                        try? document.data(as: UserData.self)
                    }
                }
            }
    }
    
    func addUserData(_ userData: UserData) {
        do {
            let userData = userData
            userData.userId = self.userId // (10)
            let _ = try db.collection(userDatasPath).addDocument(from: userData)
        }
        catch {
            fatalError("Unable to encode UserData: \(error.localizedDescription).")
        }
    }
    
    func removeUserData(_ userData: UserData) {
        if let userDataID = userData.id {
            db.collection(userDatasPath).document(userDataID).delete { (error) in
                if let error = error {
                    print("Unable to remove document: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func updateUserData(_ userData: UserData) {
        if let userDataID = userData.id {
            do {
                try db.collection(userDatasPath).document(userDataID).setData(from: userData)
            }
            catch {
                fatalError("Unable to encode UserData: \(error.localizedDescription).")
            }
        }
    }
}
