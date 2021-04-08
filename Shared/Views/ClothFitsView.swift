//
//  ClothFitsView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/29/21.
//

import SwiftUI
import Resolver

struct ClothFitsView: View {
    @Binding var clothItemsRepo: ClothItemRepository
    @Binding var clothFitsRepo: ClothFitRepository
    
    var body: some View {
            List {
                if clothFitsRepo.clothFits.isEmpty {
                    Text("You have \(clothFitsRepo.clothFits.count) fits")
                } else {
                    ForEach(clothFitsRepo.clothFits) {clothFit in
                        VStack {
                            NavigationLink(
                                destination: ClothFitDetailView(clothItemsRepo: $clothItemsRepo, clothFits: clothFitsRepo.clothFits, clothFit: clothFit),
                                label: {
                                    ClothFitView(clothFit: clothFit, clothItems: clothItemsRepo.clothItems)
                                        .frame(width: 300, height: 250)
                                })
                        }
                    }.onDelete(perform: removeRows)
                }
            }
    }
    private func removeRows(at offsets: IndexSet) {
        for i in offsets {
            let removeFit = clothFitsRepo.clothFits[i]
            withAnimation {
                clothFitsRepo.removeClothFit(removeFit)
            }
        }
    }
}

struct ClothFitsView_Previews: PreviewProvider {
    static var previews: some View {
        ClothFitsView(clothItemsRepo: .constant(Resolver.resolve()), clothFitsRepo: .constant(Resolver.resolve()))
    }
}
