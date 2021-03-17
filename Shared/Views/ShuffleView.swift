//
//  GameView.swift
//  Shared
//
//  Created by Dante Gil-Marin on 3/8/21.
//

import SwiftUI

struct ShuffleView: View {
    @Binding var clothFits: [ClothFit]
    let clothItems: [ClothItem]
    @Binding var triedClothFits: [ClothFit]
    @State var clothFit: ClothFit?
    var body: some View {
        if clothFit != nil {
                var fit = clothFit!
            VStack {
                ClothFitView(clothFit: clothFit, clothItems: clothItems)
                    .frame(width: 300, height: 250)
                HStack {
                    Button(action: {
                        triedClothFits.append(fit)
                        clothFit = randomClothFit(clothItems: clothItems, triedClothFits: triedClothFits)!
                    }) {
                        Image(systemName: "xmark.circle")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.red)
                    }
                    Spacer()
                    Button(action: {
                        fit.star = true
                        clothFits.append(fit)
                        triedClothFits.append(fit)
                        clothFit = randomClothFit(clothItems: clothItems, triedClothFits: triedClothFits)!
                    }) {
                        Image(systemName: "star")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.yellow)
                    }
                    Spacer()
                    Button(action: {
                        clothFits.append(fit)
                        triedClothFits.append(fit)
                        clothFit = randomClothFit(clothItems: clothItems, triedClothFits: triedClothFits)!
                    }) {
                        Image(systemName: "checkmark.circle")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.green)
                    }
                }
                .padding()
            }
            .padding(.top, 150)
        } else {
            VStack {
                Text("You have \(clothItems.count) items")
                Text("please add items")
                Button(action: {
                    clothFit = randomClothFit(clothItems: clothItems, triedClothFits: triedClothFits)!
                }) {
                    Image(systemName: "shuffle")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.green)
                }
            }
        }
    }
    private func randomClothFit(clothItems: [ClothItem], triedClothFits: [ClothFit]) -> ClothFit? {
        var found: Bool = false
        var clothFit: ClothFit? = nil
        while !found {
            let top: ClothItem = clothItems.randomElement()!
            let bottom: ClothItem = clothItems.randomElement()!
            if top != bottom {
                clothFit = ClothFit(items: [top.id, bottom.id], star: false)
                if !triedClothFits.contains(clothFit!) {
                    found = true
                }
            }
        }
        return clothFit
    }
}

struct ShuffleView_Previews: PreviewProvider {
    static var previews: some View {
        ShuffleView(clothFits: .constant(ClothFit.data), clothItems: ClothItem.data, triedClothFits: .constant(ClothFit.data), clothFit: ClothFit.data[0])
    }
}
