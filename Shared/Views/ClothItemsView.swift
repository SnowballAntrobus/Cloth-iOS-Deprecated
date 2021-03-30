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
    let clothFits: [ClothFit]
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(clothItems) {clothItem in
                        VStack {
                        NavigationLink(
                            destination: ClothItemDetailView(clothItem: binding(for: clothItem), clothFits: clothFits, clothItems: clothItems)) {
                            ClothItemView(clothItem: clothItem)
                                .frame(width: 100, height: 100)
                            }
                    }
                        .overlay(DeleteButton(number: clothItem, numbers: $clothItems, onDelete: removeRows), alignment: .topTrailing)
                    }.onDelete(perform: removeRows)
                }
            }.navigationBarHidden(true)
        }
    }
    
    private func binding(for clothItem: ClothItem) -> Binding<ClothItem> {
            guard let clothItemIndex = clothItems.firstIndex(where: { $0.id == clothItem.id }) else {
                fatalError("Can't find scrum in array")
            }
            return $clothItems[clothItemIndex]
    }
    
    func removeRows(at offsets: IndexSet) {
            withAnimation {
                clothItems.remove(atOffsets: offsets)
            }
    }
}

struct ClothItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ClothItemsView(clothItems: .constant(ClothItem.data), clothFits: ClothFit.data)
    }
}
