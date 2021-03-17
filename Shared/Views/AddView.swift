//
//  AddView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/16/21.
//

import SwiftUI

struct AddView: View {
    @Binding var clothItems: [ClothItem]
    @State private var isPresented = false
    @State private var newclothItemData = ClothItem.Data()
    var body: some View {
        VStack {
            Text("AddView")
            Button(action: { isPresented = true }) {
                Image(systemName: "plus")
            }
            .sheet(isPresented: $isPresented) {
                NavigationView {
                    ClothItemEditView(clothItemData: $newclothItemData)
                        .navigationBarItems(leading: Button("Dismiss") {
                            isPresented = false
                        }, trailing: Button("Add") {
                            let newclothItem = ClothItem(type: newclothItemData.type, color: newclothItemData.color, brand: newclothItemData.brand, price: newclothItemData.price, imageName: "UserImage")
                                clothItems.append(newclothItem)
                                isPresented = false
                            })
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(clothItems: .constant(ClothItem.data))
    }
}
