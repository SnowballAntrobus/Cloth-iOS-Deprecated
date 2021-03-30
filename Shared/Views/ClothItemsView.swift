//
//  ClothItemsView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/29/21.
//

import SwiftUI

struct ClothItemsView: View {
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    @Binding var clothItems: [ClothItem]
    @Binding var clothFits: [ClothFit]
    @Binding var userData: UserData
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(clothItems) {clothItem in
                    VStack {
                        NavigationLink(
                            destination: ClothItemDetailView(clothItem: binding(for: clothItem), clothFits: clothFits, clothItems: $clothItems)) {
                            ClothItemView(clothItem: clothItem)
                                .frame(width: 100, height: 100)
                        }
                    }
                    .overlay(DeleteButton(number: clothItem, numbers: $clothItems, onDelete: removeRows), alignment: .topTrailing)
                }.onDelete(perform: removeRows)
            }
        }.navigationBarHidden(true)
    }
    
    private func binding(for clothItem: ClothItem) -> Binding<ClothItem> {
        guard let clothItemIndex = clothItems.firstIndex(where: { $0.id == clothItem.id }) else {
            fatalError("Can't find scrum in array")
        }
        return $clothItems[clothItemIndex]
    }
    
    private func removeRows(at offsets: IndexSet) {
        offsets.forEach { (i) in
            let removedItem = clothItems[i]
            removeFits(removedItem: removedItem)
        }
        withAnimation {
            clothItems.remove(atOffsets: offsets)
        }
    }
    func removeFits(removedItem: ClothItem) {
        var idxsFit: [Int] = []
        var idxsTried: [Int] = []
        for (n, fit) in clothFits.enumerated() {
            if (fit.items.contains(removedItem.id)) {
                idxsFit.append(n)
            }
        }
        for (n, fit) in userData.triedClothFits.enumerated() {
            if (fit.items.contains(removedItem.id)) {
                idxsTried.append(n)
            }
        }
        clothFits.remove(atOffsets: IndexSet(idxsFit))
        userData.triedClothFits.remove(atOffsets: IndexSet(idxsTried))
    }
}

struct ClothItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ClothItemsView(clothItems: .constant(ClothItem.data), clothFits: .constant(ClothFit.data), userData: .constant(UserData.data[0]))
    }
}

struct DeleteButton<T>: View where T: Equatable {
    @Environment(\.editMode) var editMode
    
    let number: T
    @Binding var numbers: [T]
    let onDelete: (IndexSet) -> ()
    
    var body: some View {
        VStack {
            if self.editMode?.wrappedValue == .active {
                Button(action: {
                    if let index = numbers.firstIndex(of: number) {
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
