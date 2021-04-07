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
    @StateObject var state = AppState()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(state)
        }
    }
}
