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
        NavigationView {
            VStack {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(clothItemsRepo.clothItems) {clothItem in
                            VStack {
                                NavigationLink(
                                    destination: ClothItemDetailView(clothItemsRepo: $clothItemsRepo, clothItem: binding(for: clothItem), clothFits: clothFitsRepo.clothFits)) {
                                    ClothItemView(clothItem: clothItem)
                                        .frame(width: 100, height: 100)
                                }
                            }
                        }
                    }
                }.navigationBarHidden(true)
            }
        }
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
