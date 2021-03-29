//
//  ClothItemEditView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/16/21.
//

import SwiftUI
import Combine

struct ClothItemEditView: View {
    @Binding var clothItemData: ClothItem.Datas
    var body: some View {
        List {
            HStack{
                Spacer()
                if clothItemData.image != nil {
                    let image: UIImage = UIImage(data: clothItemData.image!)!
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(10)
                } else {
                    Image(systemName: "square.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(10)
                }
                Spacer()
            }
            HStack {
                Label("Type", systemImage: "book.closed")
                    .foregroundColor(.green)
                Picker("", selection: $clothItemData.type) {
                        ForEach(ClothItemType.allCases, id: \.self) { value in
                            Text(value.rawValue.capitalized)
                                }
                            }
            }
            HStack {
                Label("Color", systemImage: "paintpalette")
                    .foregroundColor(.green)
                TextField("Color", text: $clothItemData.color)
            }
            HStack {
                Label("Brand", systemImage: "books.vertical")
                    .foregroundColor(.green)
                TextField("Brand", text: $clothItemData.brand)
            }
            HStack {
                Label("Price", systemImage: "dollarsign.square")
                    .foregroundColor(.green)
                TextField("Price", text: $clothItemData.price)
                    .keyboardType(.numberPad)
                    .onReceive(Just(clothItemData.price)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.clothItemData.price = filtered
                        }
                    }
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}

struct ClothItemEditView_Previews: PreviewProvider {
    static var previews: some View {
        ClothItemEditView(clothItemData: .constant(ClothItem.data[0].data))
    }
}
