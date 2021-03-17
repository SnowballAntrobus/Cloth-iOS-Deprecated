//
//  ClothFitView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/16/21.
//

import SwiftUI

struct ClothFitView: View {
    let clothFit: ClothFit
    var body: some View {
        List{
            ForEach(clothFit.items) { clothItem in
                HStack {
                    Spacer()
                    let image: UIImage = UIImage(data: clothItem.image!)!
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 100, height: 100)
                    Spacer()
                }
            }
        }
    }
}

struct ClothFitView_Previews: PreviewProvider {
    static var clothFit = ClothFit.data[0]
    static var previews: some View {
        ClothFitView(clothFit: clothFit)
            .previewLayout(.fixed(width: 300, height: 250))
    }
}
