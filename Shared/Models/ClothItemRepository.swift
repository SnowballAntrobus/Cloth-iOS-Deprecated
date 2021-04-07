//
//  UserDataRepository.swift
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
