//
//  ClothApp.swift
//  Shared
//
//  Created by Dante Gil-Marin on 3/8/21.
//

import SwiftUI
import RealmSwift

let app = RealmSwift.App(id: "clothapp-hdgci")

@main
struct ClothApp: SwiftUI.App {
    @ObservedObject private var user = User()
    var body: some Scene {
        WindowGroup {
            MainView(clothItems: $user.clothItems, clothFits: $user.clothFits, userData: $user.userData) {
                user.save()
            }
            .onAppear {
                user.load()
            }
        }
    }
}
