//
//  ClothItemDetailView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/16/21.
//

import SwiftUI

struct ClothItemDetailView: View {
    @Binding var clothItem: ClothItem
    @State private var clothItemData: ClothItem.Data = ClothItem.Data()
    @State private var isPresented = false
    var body: some View {
        
        List {
            HStack{
                Spacer()
                clothItem.image
                    .resizable()
                    .frame(width: 200, height: 200)
                Spacer()
            }
                
            HStack {
                Label("Type", systemImage: "book.closed")
                    .foregroundColor(.green)
                Spacer()
                Text("\(clothItem.type)")
            }
            HStack {
                Label("Color", systemImage: "paintpalette")
                    .foregroundColor(.green)
                Spacer()
                Text("\(clothItem.color)")
            }
            HStack {
                Label("Brand", systemImage: "books.vertical")
                    .foregroundColor(.green)
                Spacer()
                Text("\(clothItem.brand)")
            }
            HStack {
                Label("Price", systemImage: "dollarsign.square")
                    .foregroundColor(.green)
                Spacer()
                Text("\(clothItem.price)")
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarItems(trailing: Button("Edit"){
            isPresented = true
            clothItemData = clothItem.data
        })
        .fullScreenCover(isPresented: $isPresented) {
            NavigationView {
                ClothItemEditView(clothItemData: $clothItemData)
                    .navigationBarItems(leading: Button("Cancel") {
                        isPresented = false
                    }, trailing: Button("Done") {
                        isPresented = false
                        clothItem.update(from: clothItemData)
                    })
            }
        }
        
    }
}

struct ClothItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ClothItemDetailView(clothItem: .constant(ClothItem.data[0]))
        }
    }
}
