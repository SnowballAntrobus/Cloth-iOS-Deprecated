//
//  ClothApp.swift
//  Shared
//
//  Created by Dante Gil-Marin on 3/8/21.
//


import SwiftUI
import Resolver
import Firebase
import FirebaseUI

@main
struct ClothApp: App {
    
    @Injected var authenticationService: AuthenticationService
    
    init() {
        FirebaseApp.configure()
        SDImageLoadersManager.shared.loaders = [FirebaseUI.StorageImageLoader.shared]
        SDWebImageManager.defaultImageLoader = SDImageLoadersManager.shared
        
        authenticationService.signIn()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        register { AuthenticationService() }.scope(.application)
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



