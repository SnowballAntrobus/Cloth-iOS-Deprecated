//
//  ClothFitDetailView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/30/21.
//

import SwiftUI

struct ClothFitDetailView: View {
    @Binding var clothItems: [ClothItem]
    let clothFit: ClothFit
    let clothFits: [ClothFit]
    
    var body: some View {
        List {
            VStack {
                let clothItem1: ClothItem? = findClothItem(clothItems: clothItems, clothItemId: clothFit.items[0])
                HStack{
                    Spacer()
                    if clothItem1 != nil {
                        NavigationLink(
                            destination: ClothItemDetailView(clothItem: binding(for: clothItem1!), clothFits: clothFits, clothItems: $clothItems)) {
                            ClothItemView(clothItem: clothItem1!)
                                .frame(width: 100, height: 100)
                        }
                    }else{
                        Image(systemName: "square.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                    Spacer()
                }
                let clothItem2: ClothItem? = findClothItem(clothItems: clothItems, clothItemId: clothFit.items[1])
                HStack{
                    Spacer()
                    if clothItem2 != nil {
                        NavigationLink(
                            destination: ClothItemDetailView(clothItem: binding(for: clothItem2!), clothFits: clothFits, clothItems: $clothItems)) {
                            ClothItemView(clothItem: clothItem2!)
                                .frame(width: 100, height: 100)
                        }
                    }else {
                        Image(systemName: "square.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                    Spacer()
                }
            }.padding()
            
            HStack {
                Label("Uses", systemImage: "list.number")
                    .foregroundColor(.green)
                Spacer()
                Text("\(clothFit.use)")
            }
            
            HStack {
                Label("Price", systemImage: "dollarsign.square")
                    .foregroundColor(.green)
                Spacer()
                Text("\(clothFit.price)")
            }
        }
    }
    private func findClothItem(clothItems: [ClothItem], clothItemId: UUID) -> ClothItem? {
        for i in 0..<clothItems.count {
            if clothItems[i].id == clothItemId {
                return clothItems[i]
            }
        }
        return nil
    }
    private func binding(for clothItem: ClothItem) -> Binding<ClothItem> {
        guard let clothItemIndex = clothItems.firstIndex(where: { $0.id == clothItem.id }) else {
            fatalError("Can't find scrum in array")
        }
        return $clothItems[clothItemIndex]
    }
}

struct ClothFitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ClothFitDetailView(clothItems: .constant(ClothItem.data), clothFit: ClothFit.data[0], clothFits: ClothFit.data)
    }
}
