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
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        NavigationView {
        VStack {
            HStack {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "line.horizontal.3.decrease.circle")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.green)
                })
                Spacer()
                Button(action: {itemType = !itemType}, label: {
                    Text(itemType ? "Cloth" : "Fit")
                        .foregroundColor(.green)
                })
            }
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(clothItems) {clothItem in
                        NavigationLink(
                            destination: ClothItemDetailView(clothItem: binding(for: clothItem))) {
                            ClothItemView(clothItem: clothItem)
                                .frame(width: 100, height: 100)
                            }
                    }
                }
            }
            .padding(.top, 10)
            .navigationBarHidden(true)
        }
        .padding()
        }
        .navigationBarHidden(true)
    }
    
    private func binding(for clothItem: ClothItem) -> Binding<ClothItem> {
            guard let clothItemIndex = clothItems.firstIndex(where: { $0.id == clothItem.id }) else {
                fatalError("Can't find scrum in array")
            }
            return $clothItems[clothItemIndex]
        }
}

struct ClosetView_Previews: PreviewProvider {
    static var previews: some View {
        ClosetView(clothItems: .constant(ClothItem.data))
    }
}
