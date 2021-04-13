//
//  ShuffleView.swift
//  Shared
//
//  Created by Dante Gil-Marin on 3/8/21.
//

import SwiftUI
import Resolver

struct ShuffleView: View {
    @Binding var clothItemsRepo: ClothItemRepository
    @Binding var clothFitsRepo: ClothFitRepository
    @Binding var userDataRepo: UserDataRepository
    
    @State var clothFit: ClothFit?
    @State var updateUserData: UserData?
    var body: some View {
        if clothFit != nil {
            var fit = clothFit!
            VStack {
                ClothFitView(clothFit: clothFit, clothItems: clothItemsRepo.clothItems)
                    .frame(width: 300, height: 250)
                HStack {
                    Button(action: {
                        updateUserData = userDataRepo.userDatas[0]
                        updateUserData!.triedClothFits.append(clothFit!)
                        userDataRepo.updateUserData(updateUserData!)
                        clothFit = randomClothFit(clothItems: clothItemsRepo.clothItems, triedClothFits: userDataRepo.userDatas[0].triedClothFits)!
                    }) {
                        Image(systemName: "xmark.circle")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.red)
                    }
                    Spacer()
                    Button(action: {
                        fit.star = true
                        clothFitsRepo.clothFits.append(fit)
                        updateUserData = userDataRepo.userDatas[0]
                        updateUserData!.triedClothFits.append(clothFit!)
                        userDataRepo.updateUserData(updateUserData!)
                        clothFit = randomClothFit(clothItems: clothItemsRepo.clothItems, triedClothFits: userDataRepo.userDatas[0].triedClothFits)!
                    }) {
                        Image(systemName: "star")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.yellow)
                    }
                    Spacer()
                    Button(action: {
                        clothFitsRepo.clothFits.append(fit)
                        updateUserData = userDataRepo.userDatas[0]
                        updateUserData!.triedClothFits.append(clothFit!)
                        userDataRepo.updateUserData(updateUserData!)
                        clothFit = randomClothFit(clothItems: clothItemsRepo.clothItems, triedClothFits: userDataRepo.userDatas[0].triedClothFits)!
                    }) {
                        Image(systemName: "checkmark.circle")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.green)
                    }
                }
                .padding()
            }
            .padding(.top, 150)
        } else {
            if userDataRepo.userData != nil {
                VStack {
                    Text("You have \(clothItemsRepo.clothItems.count) items")
                    Text("please add items")
                    Button(action: {
                        clothFit = randomClothFit(clothItems: clothItemsRepo.clothItems, triedClothFits: userDataRepo.userDatas[0].triedClothFits)!
                    }) {
                        Image(systemName: "shuffle")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.green)
                    }
                }
            } else {
                PleaseCreateAccount()
            }
        }
    }
    
    private func randomClothFit(clothItems: [ClothItem], triedClothFits: [ClothFit]) -> ClothFit? {
        var found: Bool = false
        var clothFit: ClothFit? = nil
        while !found {
            let top: ClothItem = clothItems.filter{$0.type == "Top"}.randomElement()!
            let bottom: ClothItem = clothItems.filter{$0.type == "Bottom"}.randomElement()!
            if top != bottom {
                clothFit = ClothFit(items: [top.id!, bottom.id!], star: false)
                if !triedClothFits.contains(clothFit!) {
                    found = true
                }
            }
        }
        return clothFit
    }
}

struct ShuffleView_Previews: PreviewProvider {
    static var previews: some View {
        ShuffleView(clothItemsRepo: .constant(Resolver.resolve()), clothFitsRepo: .constant(Resolver.resolve()), userDataRepo: .constant(Resolver.resolve()))
    }
}
