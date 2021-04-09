//
//  ClothItemView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/16/21.
//

import SwiftUI

struct ClothItemView: View {
    let clothItem: ClothItem
    var body: some View {
        if clothItem.imageURL != "" {
            Image(uiImage: clothItem.getImage()!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(10)
        } else {
            Image(systemName: "square.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(10)
        }
    }
}

struct ClothItemView_Previews: PreviewProvider {
    static var clothItem = ClothItem.data[0]
    static var previews: some View {
        ClothItemView(clothItem: clothItem)
            .previewLayout(.fixed(width: 100, height: 100))
    }
}
