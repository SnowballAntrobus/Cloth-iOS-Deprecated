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
    let clothFits: [ClothFit]
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
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
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(clothItems) {clothItem in
                            VStack {
                            NavigationLink(
                                destination: ClothItemDetailView(clothItem: binding(for: clothItem))) {
                                ClothItemView(clothItem: clothItem)
                                    .frame(width: 100, height: 100)
                                }
                        }
                            .overlay(DeleteButton(number: clothItem, numbers: $clothItems, onDelete: removeRows), alignment: .topTrailing)
                        }.onDelete(perform: removeRows)
                    }
                }
                .padding(.top, 10)
                .navigationBarHidden(true)
            } else {
                List {
                    if clothFits.isEmpty {
                        Text("You have \(clothFits.count) fits")
                    } else {
                        ForEach(clothFits) {clothFit in
                            HStack {
                                Spacer()
                                ClothFitView(clothFit: clothFit,clothItems: clothItems)
                                    .frame(width: 300, height: 250)
                                Spacer()
                            }
                        }
                    }
                }
                .navigationBarHidden(true)
            }
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
    func removeRows(at offsets: IndexSet) {
            withAnimation {
                clothItems.remove(atOffsets: offsets)
            }
    }
}

struct DeleteButton<T>: View where T: Equatable {
    @Environment(\.editMode) var editMode

    let number: T
    @Binding var numbers: [T]
    let onDelete: (IndexSet) -> ()

    var body: some View {
        VStack {
            if self.editMode?.wrappedValue == .active {
                Button(action: {
                    if let index = numbers.firstIndex(of: number) {
                        self.onDelete(IndexSet(integer: index))
                    }
                }) {
                    Image(systemName: "minus.circle")
                }
                .offset(x: 10, y: 0)
            }
        }
    }
}


struct ClosetView_Previews: PreviewProvider {
    static var previews: some View {
        ClosetView(clothItems: .constant(ClothItem.data), clothFits: ClothFit.data)
    }
}
