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
    let clothFits: [ClothFit]
    
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
                    ClothItemsView(clothItems: $clothItems)
                    .padding(.top, 10)
                    .navigationBarHidden(true)
                } else {
                    ClothFitsView(clothItems: clothItems, clothFits: clothFits)
                    .navigationBarHidden(true)
                }
            }
            .padding()
        }    }
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
