//
//  ClothFitView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/16/21.
//

import SwiftUI

struct ClothFitView: View {
    let clothFit: ClothFit?
    let clothItems: [ClothItem]
    var idx: Int = 0
    var body: some View {
        if clothFit != nil {
            let fit = clothFit!
            VStack {
                HStack {
                    Spacer()
                    let clothItem: ClothItem? = findClothItem(clothItems: clothItems, clothItemId: fit.items[0])
                    if clothItem?.image != nil {
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
                HStack {
                    Spacer()
                    let clothItem: ClothItem? = findClothItem(clothItems: clothItems, clothItemId: fit.items[1])
                    if clothItem?.image != nil {
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
        } else {
            Image(systemName: "square.fill")
                .resizable()
                .frame(width: 100, height: 100)
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
