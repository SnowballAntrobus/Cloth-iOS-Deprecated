//
//  MainView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/16/21.
//

import SwiftUI

struct MainView: View {
    @Binding var clothItems: [ClothItem]
    @Binding var clothFits: [ClothFit]
    @Binding var userData: UserData
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: () -> Void
    var body: some View {
        TabView {
            ShuffleView(clothFits: clothFits)
                .tabItem { Label("Cloth", systemImage:"shuffle") }
            AddView(clothItems: $clothItems)
                .tabItem { Label("Add", systemImage:"plus.circle") }
            ClosetView(clothItems: $clothItems)
                .tabItem { Label("Closet", systemImage:"book") }
            AccountView(userData: $userData)
                .tabItem { Label("Account", systemImage:"person") }
        }
        .accentColor(.green)
        .onChange(of: scenePhase) { phase in if phase == .inactive { saveAction() } }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(clothItems: .constant(ClothItem.data), clothFits: .constant(ClothFit.data), userData: .constant(UserData.data[0]), saveAction: {})
    }
}
