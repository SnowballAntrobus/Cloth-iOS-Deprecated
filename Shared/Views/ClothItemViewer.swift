//
//  ClothItemsViewer.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/29/21.
//

import SwiftUI

struct ClothItemsViewer: View {
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    @Binding var clothItems: [ClothItem]
    @Binding var selectItem: ClothItem?
    var body: some View {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(clothItems) {clothItem in
                        VStack {
                            Button(action: {selectItem = clothItem}, label: {
                                ClothItemView(clothItem: clothItem)
                                    .frame(width: 100, height: 100)
                            })
                    }
                        .overlay(DeleteButton(number: clothItem, numbers: $clothItems, onDelete: removeRows), alignment: .topTrailing)
                    }.onDelete(perform: removeRows)
                }
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

struct ClothItemsViewer_Previews: PreviewProvider {
    static var previews: some View {
        ClothItemsViewer(clothItems: .constant(ClothItem.data), selectItem: .constant(ClothItem.data[0]))
    }
}
