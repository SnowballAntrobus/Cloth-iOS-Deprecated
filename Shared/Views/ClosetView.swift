//
//  ClosetView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/9/21.
//

import SwiftUI

struct ClosetView: View {
    @State private var itemType = true
    @Binding var clothItems: [ClothItem]
    
    @State var selectItem: ClothItem? = nil
    @Binding var clothFits: [ClothFit]
    
    @Binding var userData: UserData
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    EditButton()
                        .foregroundColor(.green)
                    Spacer()
                    Button(action: {itemType = !itemType}, label: {
                        Text(itemType ? "Cloth" : "Fit")
                            .foregroundColor(.green)
                    })
                }
                if itemType {
                    ClothItemsView(clothItems: $clothItems, clothFits: $clothFits, userData: $userData)
                    .padding(.top, 10)
                    .navigationBarHidden(true)
                } else {
                    ClothFitsView(clothItems: $clothItems, clothFits: $clothFits)
                    .navigationBarHidden(true)
                }
            }
            .padding()
        }
    }
}


struct ClosetView_Previews: PreviewProvider {
    static var previews: some View {
        ClosetView(clothItems: .constant(ClothItem.data), clothFits: .constant(ClothFit.data), userData: .constant(UserData.data[0]))
    }
}
