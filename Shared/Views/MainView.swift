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
            ShuffleView(clothItemsRepo: $clothItemsRepo, clothFitsRepo: $clothFitsRepo, userDataRepo: $userDataRepo, clothFit: randomClothFit(clothItems: clothItemsRepo.clothItems, triedClothFits: userDataRepo.userDatas[0].triedClothFits))
                .tabItem { Label("Cloth", systemImage:"shuffle") }
            AddView(clothItemsRepo: $clothItemsRepo, clothFitsRepo: $clothFitsRepo, userDataRepo: $userDataRepo)
                .tabItem { Label("Add", systemImage:"plus.circle") }
            ClosetView(clothItemsRepo: $clothItemsRepo, clothFitsRepo: $clothFitsRepo, userDataRepo: $userDataRepo)
                .tabItem { Label("Closet", systemImage:"book") }
            AccountView(userDataRepo: $userDataRepo)
                .tabItem { Label("Account", systemImage:"person") }
//            testView()
//                .tabItem { Label("Test", systemImage:"square") }
        }
        .accentColor(.green)
    }
    private func randomClothFit(clothItems: [ClothItem], triedClothFits: [ClothFit]) -> ClothFit? {
        if clothItems.isEmpty {
            return nil
        }
        var found: Bool = false
        var clothFit: ClothFit? = nil
        while !found {
            let top: ClothItem = clothItems.filter{$0.type == "Top"}.randomElement()!
            let bottom: ClothItem = clothItems.filter{$0.type == "Bottom"}.randomElement()!
            if top != bottom {
                clothFit = ClothFit(items: [top.id!, bottom.id!], star: false)
                if !triedClothFits.contains(clothFit!) {
                    found = true
                }
            }
        }
        return clothFit
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(clothItemsRepo: Resolver.resolve(), clothFitsRepo: Resolver.resolve(), userDataRepo: Resolver.resolve())
    }
}
