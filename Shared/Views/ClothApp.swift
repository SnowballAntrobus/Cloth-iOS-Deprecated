//
//  ClothApp.swift
//  Shared
//
//  Created by Dante Gil-Marin on 3/8/21.
//


import SwiftUI
import Resolver
import Firebase

@main
struct ClothApp: App {
    @State var clothItemsRepo: ClothItemRepository = Resolver.resolve()
    @State var clothFitsRepo: ClothFitRepository = Resolver.resolve()
    @State var userDataRepo: UserDataRepository = Resolver.resolve()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView(clothItemsRepo: $clothItemsRepo, clothFitsRepo: $clothFitsRepo, userDataRepo: $userDataRepo)
        }
    }
}

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        register { FirestoreClothItemRepository() as ClothItemRepository }.scope(.application)
        register { FirestoreClothFitRepository() as ClothFitRepository }.scope(.application)
        
        //        register { LocalClothItemRepository() as ClothItemRepository }.scope(.application)
        //        register { LocalClothFitRepository() as ClothFitRepository }.scope(.application)
        //        register { LocalUserDataRepository() as UserDataRepository }.scope(.application)
        
        //        register { TestDataClothItemRepository() as ClothItemRepository }.scope(.application)
        //        register { TestDataClothFitRepository() as ClothFitRepository }.scope(.application)
        register { TestDataUserDataRepository() as UserDataRepository }.scope(.application)
    }
}
