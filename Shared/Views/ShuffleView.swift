//
//  GameView.swift
//  Shared
//
//  Created by Dante Gil-Marin on 3/8/21.
//

import SwiftUI

struct ShuffleView: View {
    var clothFits: [ClothFit]
    var body: some View {
        VStack {
            VStack {
                ClothFitView(clothFit: clothFits[0])
                    .frame(width: 300, height: 250)
                HStack {
                    Button(action: {}) {
                        Image(systemName: "xmark.circle")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.red)
                    }
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "star")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.yellow)
                    }
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "checkmark.circle")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.green)
                    }
                }
                .padding()
            }
            .padding(.top, 150)
        }
        .padding()
    }
}

struct ShuffleView_Previews: PreviewProvider {
    static var clothFits = ClothFit.data
    static var previews: some View {
        ShuffleView(clothFits: clothFits)
    }
}
