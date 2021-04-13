//
//  AuthenticationService.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 4/13/21.
//

import Foundation
import Firebase

class AuthenticationService: ObservableObject {
  
  @Published var user: User?
  
  func signIn() {
    registerStateListener()
    Auth.auth().signInAnonymously()
  }
  
  private func registerStateListener() {
    Auth.auth().addStateDidChangeListener { (auth, user) in
      print("Sign in state has changed.")
      self.user = user
      
      if let user = user {
        let anonymous = user.isAnonymous ? "anonymously " : ""
        print("User signed in \(anonymous)with user ID \(user.uid).")
      }
      else {
        print("User signed out.")
      }
    }
  }
  
}
