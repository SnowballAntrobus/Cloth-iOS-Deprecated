//
//  ClosetView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/9/21.
//

import SwiftUI
import Resolver

struct ClosetView: View {
    @Binding var clothItemsRepo: ClothItemRepository
    @Binding var clothFitsRepo: ClothFitRepository
    @Binding var userDataRepo: UserDataRepository
    
    @State private var itemType = true
    @State var selectItem: ClothItem? = nil
    
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
                    ClothItemsView(clothItemsRepo: $clothItemsRepo, clothFitsRepo: $clothFitsRepo, userDataRepo: $userDataRepo)
                    .padding(.top, 10)
                    .navigationBarHidden(true)
                } else {
                    ClothFitsView(clothItemsRepo: $clothItemsRepo, clothFitsRepo: $clothFitsRepo)
                    .navigationBarHidden(true)
                }
            }
            .padding()
        }
    }
}


struct ClosetView_Previews: PreviewProvider {
    static var previews: some View {
        ClosetView(clothItemsRepo: .constant(Resolver.resolve()), clothFitsRepo: .constant(Resolver.resolve()), userDataRepo: .constant(Resolver.resolve()))
    }
}
