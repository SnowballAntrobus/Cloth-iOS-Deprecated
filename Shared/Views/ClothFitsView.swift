//
//  ClothFitsView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/29/21.
//

import SwiftUI

struct ClothFitsView: View {
    @Binding var clothItems: [ClothItem]
    let clothFits: [ClothFit]
    
    var body: some View {
            List {
                if clothFits.isEmpty {
                    Text("You have \(clothFits.count) fits")
                } else {
                    ForEach(clothFits) {clothFit in
                        HStack {
                            Spacer()
                            NavigationLink(
                                destination: ClothFitDetailView(clothItems: $clothItems, clothFit: clothFit, clothFits: clothFits),
                                label: {
                                    ClothFitView(clothFit: clothFit, clothItems: clothItems)
                                        .frame(width: 300, height: 250)
                                })
                            Spacer()
                        }
                    }
                }
            }
    }
}

struct ClothFitsView_Previews: PreviewProvider {
    static var previews: some View {
        ClothFitsView(clothItems: .constant(ClothItem.data), clothFits: ClothFit.data)
    }
}
