//
//  ClothItemsView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/29/21.
//

import SwiftUI
import Resolver

struct ClothItemsView: View {
    @Binding var clothItemsRepo: ClothItemRepository
    @Binding var clothFitsRepo: ClothFitRepository
    @Binding var userDataRepo: UserDataRepository
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
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
                    .overlay(DeleteButton<ClothItem>(number: clothItem, numbers: $clothItemsRepo, onDelete: removeRows), alignment: .topTrailing)
                }.onDelete(perform: removeRows)
            }
        }.navigationBarHidden(true)
    }
    
    private func binding(for clothItem: ClothItem) -> Binding<ClothItem> {
        guard let clothItemIndex = clothItemsRepo.clothItems.firstIndex(where: { $0.id == clothItem.id }) else {
            fatalError("Can't find scrum in array")
        }
        return $clothItemsRepo.clothItems[clothItemIndex]
    }
    
    private func removeRows(at offsets: IndexSet) {
        var removedItem: ClothItem?
        offsets.forEach { (i) in
            removedItem = clothItemsRepo.clothItems[i]
            removeFits(removedItem: removedItem!)
        }
        withAnimation {
            clothItemsRepo.removeClothItem(removedItem!)
        }
    }
    func removeFits(removedItem: ClothItem) {
        var idxsTried: [Int] = []
        for fit in clothFitsRepo.clothFits {
            if (fit.items.contains(removedItem.id!)) {
                clothFitsRepo.removeClothFit(fit)
            }
        }
        for (n, fit) in userDataRepo.userDatas[0].triedClothFits.enumerated() {
            if (fit.items.contains(removedItem.id!)) {
                idxsTried.append(n)
            }
        }
        userDataRepo.userDatas[0].triedClothFits.remove(atOffsets: IndexSet(idxsTried))
    }
}

struct ClothItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ClothItemsView(clothItemsRepo: Resolver.resolve(), clothFitsRepo: Resolver.resolve(), userDataRepo: Resolver.resolve())
    }
}

struct DeleteButton<T>: View where T: Equatable {
    @Environment(\.editMode) var editMode
    
    let number: ClothItem
    @Binding var numbers: ClothItemRepository
    let onDelete: (IndexSet) -> ()
    
    var body: some View {
        VStack {
            if self.editMode?.wrappedValue == .active {
                Button(action: {
                    if let index = numbers.clothItems.firstIndex(of: number) {
                        self.onDelete(IndexSet(integer: index))
                    }
                }) {
                    Image(systemName: "minus.circle")
                }
                .offset(x: 10, y: 0)
            }
        }
    }
}
