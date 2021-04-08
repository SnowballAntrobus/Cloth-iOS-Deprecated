//
//  ClothApp.swift
//  Shared
//
//  Created by Dante Gil-Marin on 3/8/21.
//


import SwiftUI
import Resolver

@main
struct ClothApp: App {
    @State var clothItemsRepo: ClothItemRepository = Resolver.resolve()
    @State var clothFitsRepo: ClothFitRepository = Resolver.resolve()
    @State var userDataRepo: UserDataRepository = Resolver.resolve()
    
    var body: some Scene {
        WindowGroup {
            MainView(clothItemsRepo: $clothItemsRepo, clothFitsRepo: $clothFitsRepo, userDataRepo: $userDataRepo)
        }
    }
}

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        register { TestDataClothItemRepository() as ClothItemRepository }.scope(.application)
        register { TestDataClothFitRepository() as ClothFitRepository }.scope(.application)
        register { TestDataUserDataRepository() as UserDataRepository }.scope(.application)
    }
}
