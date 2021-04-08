//
//  ClothFitsViewer.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/29/21.
//
import SwiftUI
import Resolver

struct ClothFitsViewer: View {
    @Binding var clothItemsRepo: ClothItemRepository
    let clothFits: [ClothFit]
    
    var body: some View {
        List {
            if clothFits.isEmpty {
                Text("You have \(clothFits.count) fits")
            } else {
                ForEach(clothFits) {clothFit in
                    Spacer()
                    NavigationLink(
                        destination: ClothFitDetailView(clothItemsRepo: $clothItemsRepo, clothFit: clothFit, clothFits: clothFits),
                        label: {
                            ClothFitView(clothFit: clothFit, clothItems: clothItemsRepo.clothItems)
                                .frame(width: 300, height: 250)
                        })
                }
            }
        }
    }
}

struct ClothFitsViewer_Previews: PreviewProvider {
    static var previews: some View {
        ClothFitsViewer(clothItemsRepo: Resolver.resolve(), clothFits: ClothFit.data)
    }
}
