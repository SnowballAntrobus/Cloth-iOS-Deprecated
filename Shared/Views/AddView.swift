//
//  AddView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/29/21.
//

import SwiftUI

struct AddView: View {
    @Binding var clothItems: [ClothItem]
    @Binding var clothFits: [ClothFit]
    @Binding var userData: UserData
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(
                    destination: AddClothItemImageView(clothItems: $clothItems),
                    label: {
                        Text("Add Item")
                            .frame(width: 300, height: 100)
                            .background(RoundedRectangle(cornerRadius: 4).stroke())
                            .foregroundColor(.green)
                        
                    })
                    .padding()
                NavigationLink(
                    destination: AddClothFitView(clothFits: $clothFits, clothItems: $clothItems, userData: $userData),
                    label: {
                        Text("Add Fit")
                            .frame(width: 300, height: 100)
                            .background(RoundedRectangle(cornerRadius: 4).stroke())
                            .foregroundColor(.green)
                    })
                    .padding()
            }.navigationBarHidden(true)
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(clothItems: .constant(ClothItem.data), clothFits: .constant(ClothFit.data), userData: .constant(UserData.data[0]))
    }
}
