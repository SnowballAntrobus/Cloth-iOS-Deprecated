//
//  AddView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/29/21.
//

import SwiftUI
import Resolver

struct AddView: View {
    @Binding var clothItemsRepo: ClothItemRepository
    @Binding var clothFitsRepo: ClothFitRepository
    @Binding var userDataRepo: UserDataRepository
    
    var body: some View {
        if userDataRepo.userData != nil {
            NavigationView {
                VStack {
                    NavigationLink(
                        destination: AddClothItemImageView(clothItemsRepo: $clothItemsRepo),
                        label: {
                            Text("Add Item")
                                .frame(width: 300, height: 100)
                                .background(RoundedRectangle(cornerRadius: 4).stroke())
                                .foregroundColor(.green)
                            
                        })
                        .padding()
                    NavigationLink(
                        destination: AddClothFitView(clothItemsRepo: $clothItemsRepo, clothFitsRepo: $clothFitsRepo, userDataRepo: $userDataRepo),
                        label: {
                            Text("Add Fit")
                                .frame(width: 300, height: 100)
                                .background(RoundedRectangle(cornerRadius: 4).stroke())
                                .foregroundColor(.green)
                        })
                        .padding()
                }.navigationBarHidden(true)
            }
        } else {
            PleaseCreateAccount()
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(clothItemsRepo: .constant(Resolver.resolve()), clothFitsRepo: .constant(Resolver.resolve()), userDataRepo: .constant(Resolver.resolve()))
    }
}
