//
//  ClothApp.swift
//  Shared
//
//  Created by Dante Gil-Marin on 3/8/21.
//


import SwiftUI

@main
struct ClothApp: App {
    @State var clothItems: [ClothItem] = ClothItem.data
    @State var clothFits: [ClothFit] = ClothFit.data
    @State var userData: UserData = UserData.data[0]
    var body: some Scene {
        WindowGroup {
            MainView(clothItems: $clothItems, clothFits: $clothFits, userData: $userData)
        }
    }
}
