//
//  AddClothFitView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/29/21.
//

import SwiftUI

struct AddClothFitView: View {
    @Binding var clothFits: [ClothFit]
    let clothItems: [ClothItem]
    @Binding var userData: UserData
    
    @State var top: UIImage?
    @State var bottom: UIImage?
    var body: some View {
        NavigationView {
            VStack {
                if top != nil {
                    Image(uiImage: top!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 300)
                }else {
                Image(systemName: "square.tophalf.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                    .padding()
                }
                if bottom != nil {
                    Image(uiImage: bottom!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 300)
                }else {
                Image(systemName: "square.bottomhalf.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                    .padding()
                }
                Button(action: {}, label: {
                    Text("Add")
                }).padding()
            }.navigationBarHidden(true)
        }
    }
}

struct AddClothFitView_Previews: PreviewProvider {
    static var previews: some View {
        AddClothFitView(clothFits: .constant(ClothFit.data), clothItems: ClothItem.data, userData: .constant(UserData.data[0]))
    }
}
