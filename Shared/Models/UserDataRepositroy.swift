//
//  UserDataRepositroy.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 4/7/21.
//

import Foundation

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

//class LocalUserDataRepository: BaseUserDataRepository, UserDataRepository, ObservableObject {
//  override init() {
//    super.init()
//    loadData()
//  }
//  
//  func addUserData(_ userData: UserData) {
//    self.userDatas.append(userData)
//    saveData()
//  }
//  
//  func removeUserData(_ userData: UserData) {
//    if let index = userDatas.firstIndex(where: { $0.id == userData.id }) {
//      userDatas.remove(at: index)
//      saveData()
//    }
//  }
//  
//  func updateUserData(_ userData: UserData) {
//    if let index = self.userDatas.firstIndex(where: { $0.id == userData.id } ) {
//      self.userDatas[index] = userData
//      saveData()
//    }
//  }
//  
//  private func loadData() {
//    if let retrievedUserDatas = try? Disk.retrieve("userDatas.json", from: .documents, as: [UserData].self) {
//      self.userDatas = retrievedUserDatas
//    }
//  }
//  
//  private func saveData() {
//    do {
//      try Disk.save(self.userDatas, to: .documents, as: "userDatas.json")
//    }
//    catch let error as NSError {
//      fatalError("""
//        Domain: \(error.domain)
//        Code: \(error.code)
//        Description: \(error.localizedDescription)
//        Failure Reason: \(error.localizedFailureReason ?? "")
//        Suggestions: \(error.localizedRecoverySuggestion ?? "")
//        """)
//    }
//  }
//}
