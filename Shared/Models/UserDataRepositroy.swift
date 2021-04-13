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
    @Published var userData: UserData? = nil
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
        self.userData = UserData.data[0]
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
    
    @Injected var authenticationService: AuthenticationService
    var userDatasPath: String = "userDatas"
    var userId: String = "unknown"
    
    private var cancellables = Set<AnyCancellable>()
    
    override init() {
        super.init()
        
        authenticationService.$user
            .compactMap { user in
                user?.uid
            }
            .assign(to: \.userId, on: self)
            .store(in: &cancellables)
        
        // (re)load data if user changes
        authenticationService.$user
            .receive(on: DispatchQueue.main)
            .sink { user in
                self.loadData()
            }
            .store(in: &cancellables)
    }
    
    private func loadData() {
        db.collection("userId").order(by: "createdTime").addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                self.userDatas = querySnapshot.documents.compactMap { document -> UserData? in
                    try? document.data(as: UserData.self)
                }
            }
        }
        
        db.collection(userDatasPath)
            .whereField("userId", isEqualTo: self.userId)
            .addSnapshotListener { (querySnapshot, error) in
                if let querySnapshot = querySnapshot {
                    querySnapshot.documents.forEach() { doc in
                        self.userData = try? doc.data(as: UserData.self)
                        
                    }
                }
            }
    }
    
    func addUserData(_ userData: UserData) {
        do {
            let userData = userData
            userData.userId = self.userId
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
