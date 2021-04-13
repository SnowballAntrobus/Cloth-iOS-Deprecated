//
//  MainView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/16/21.
//

import SwiftUI
import Resolver

struct MainView: View {
    @State var clothItemsRepo: ClothItemRepository = Resolver.resolve()
    @State var clothFitsRepo: ClothFitRepository = Resolver.resolve()
    @State var userDataRepo: UserDataRepository = Resolver.resolve()
    
    var body: some View {
        TabView {
            LandingView(clothItemsRepo: $clothItemsRepo, clothFitsRepo: $clothFitsRepo, userDataRepo: $userDataRepo)
            .tabItem { Label("Cloth", systemImage:"network") }
            ShuffleView(clothItemsRepo: $clothItemsRepo, clothFitsRepo: $clothFitsRepo, userDataRepo: $userDataRepo)
                .tabItem { Label("Shuffle", systemImage:"shuffle") }
            AddView(clothItemsRepo: $clothItemsRepo, clothFitsRepo: $clothFitsRepo, userDataRepo: $userDataRepo)
                .tabItem { Label("Add", systemImage:"plus.circle") }
            ClosetView(clothItemsRepo: $clothItemsRepo, clothFitsRepo: $clothFitsRepo, userDataRepo: $userDataRepo)
                .tabItem { Label("Closet", systemImage:"book") }
            AccountView(userDataRepo: $userDataRepo)
                .tabItem { Label("Account", systemImage:"person") }
        }
        .accentColor(.green)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(clothItemsRepo: Resolver.resolve(), clothFitsRepo: Resolver.resolve(), userDataRepo: Resolver.resolve())
    }
}
