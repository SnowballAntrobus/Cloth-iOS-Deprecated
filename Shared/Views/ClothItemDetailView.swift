//
//  ClothItemDetailView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/16/21.
//

import SwiftUI

struct ClothItemDetailView: View {
    @Binding var clothItem: ClothItem
    @State private var clothItemData: ClothItem.Datas = ClothItem.Datas()
    @State private var isPresented = false
    let clothFits: [ClothFit]
    @State var clothFitsFiltered: [ClothFit]?
    @Binding var clothItems: [ClothItem]
    
    var body: some View {
        VStack {
            List {
                HStack{
                    Spacer()
                    if clothItem.image != nil {
                        let image: UIImage = UIImage(data: clothItem.image!)!
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
                NavigationLink(
                    destination: ClothFitsView(clothItems: $clothItems, clothFits: clothFitsFiltered ?? clothFits),
                    label: {
                        Text("Show Fits")
                            .foregroundColor(.green)
                    })
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
        }.onAppear {
            filterFits()
        }
    }
    private func filterFits() {
        clothFitsFiltered = clothFits.filter{$0.items.contains(clothItem.id)}
    }
}

struct ClothItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ClothItemDetailView(clothItem: .constant(ClothItem.data[0]), clothFits: ClothFit.data, clothItems: .constant(ClothItem.data))
        }
    }
}
