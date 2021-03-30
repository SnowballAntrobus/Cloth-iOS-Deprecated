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
                    Button(action: {selectItem = clothItem}, label: {
                        if (selectItem == clothItem) {
                            ClothItemView(clothItem: clothItem)
                                .frame(width: 100, height: 100)
                                .background(RoundedRectangle(cornerRadius: 4).stroke())
                                .foregroundColor(.green)
                        }else {
                            ClothItemView(clothItem: clothItem)
                                .frame(width: 100, height: 100)
                        }
                    })
                }
            }
        }
    }
}

struct ClothItemsViewer_Previews: PreviewProvider {
    static var previews: some View {
        ClothItemsViewer(clothItems: .constant(ClothItem.data), selectItem: .constant(ClothItem.data[0]))
    }
}
