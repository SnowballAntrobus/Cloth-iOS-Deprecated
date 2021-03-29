//
//  AddClothFitView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/29/21.
//

import SwiftUI

struct AddClothFitView: View {
    @Binding var clothFits: [ClothFit]
    var body: some View {
        Text("Hello, World!")
    }
}

struct AddClothFitView_Previews: PreviewProvider {
    static var previews: some View {
        AddClothFitView(clothFits: .constant(ClothFit.data))
    }
}
