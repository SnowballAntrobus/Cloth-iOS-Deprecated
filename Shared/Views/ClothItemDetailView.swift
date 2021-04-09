//
//  ClothItemDetailView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/16/21.
//

import SwiftUI
import Resolver

struct ClothItemDetailView: View {
    @Binding var clothItemsRepo: ClothItemRepository
    @Binding var clothItem: ClothItem
    let clothFits: [ClothFit]
    
    @State private var clothItemData: ClothItem.Datas = ClothItem.Datas()
    @State private var isPresented = false
    @State var clothFitsFiltered: [ClothFit]?
    
    var body: some View {
        VStack {
            List {
                HStack{
                    Spacer()
                    if clothItem.imageURL != "" {
                        Image(uiImage: clothItem.getImage()!)
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
                    destination: ClothFitsViewer(clothItemsRepo: $clothItemsRepo, clothFits: clothFitsFiltered ?? clothFits),
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
        clothFitsFiltered = clothFits.filter{$0.items.contains(clothItem.id!)}
    }
}

struct ClothItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ClothItemDetailView(clothItemsRepo: Resolver.resolve(), clothItem: Resolver.resolve(), clothFits: Resolver.resolve())
        }
    }
}
