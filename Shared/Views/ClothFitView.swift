//
//  ClothFitView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/16/21.
//

import SwiftUI

struct ClothFitView: View {
    let clothFit: ClothFit
    let clothItems: [ClothItem]
    var idx: Int = 0
    var body: some View {
        List{
            ForEach(clothFit.items, id: \.self) { clothItemId in
                HStack {
                    Spacer()
                    let clothItem: ClothItem? = findClothItem(clothItems: clothItems, clothItemId: clothItemId)
                    if clothItem != nil {
                        let image: UIImage = UIImage(data: clothItem!.image!)!
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 100, height: 100)
                    } else {
                        Image(systemName: "square.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                    Spacer()
                }
            }
        }
    }
    private func findClothItem(clothItems: [ClothItem], clothItemId: UUID) -> ClothItem? {
        for i in 0..<clothItems.count {
            if clothItems[i].id == clothItemId {
                return clothItems[i]
            }
        }
        return nil
    }
}

struct ClothFitView_Previews: PreviewProvider {
    static var previews: some View {
        ClothFitView(clothFit: ClothFit.data[0], clothItems: ClothItem.data)
            .previewLayout(.fixed(width: 300, height: 250))
    }
}
