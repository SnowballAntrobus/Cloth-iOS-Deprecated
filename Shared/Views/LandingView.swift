//
//  LandingView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 4/13/21.
//

import SwiftUI
import Resolver

struct LandingView: View {
    @Binding var clothItemsRepo: ClothItemRepository
    @Binding var clothFitsRepo: ClothFitRepository
    @Binding var userDataRepo: UserDataRepository
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        ClosetView(clothItemsRepo: $clothItemsRepo, clothFitsRepo: $clothFitsRepo, userDataRepo: $userDataRepo)
    }
    
    private func binding(for clothItem: ClothItem) -> Binding<ClothItem> {
        guard let clothItemIndex = clothItemsRepo.clothItems.firstIndex(where: { $0.id == clothItem.id }) else {
            fatalError("Can't find scrum in array")
        }
        return $clothItemsRepo.clothItems[clothItemIndex]
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView(clothItemsRepo: .constant(Resolver.resolve()), clothFitsRepo: .constant(Resolver.resolve()), userDataRepo: .constant(Resolver.resolve()))
    }
}
