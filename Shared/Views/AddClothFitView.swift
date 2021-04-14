//
//  AddClothFitView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/29/21.
//

import SwiftUI
import Resolver

private enum ActiveSheet: Identifiable {
    case top, bottom
    
    var id: Int {
        hashValue
    }
}

struct AddClothFitView: View {
    @Binding var clothItemsRepo: ClothItemRepository
    @Binding var clothFitsRepo: ClothFitRepository
    @Binding var userDataRepo: UserDataRepository
    
    @State var clothItemsFiltered: [ClothItem]?
    @State var top: ClothItem?
    @State var bottom: ClothItem?
    @State var star: Bool = false
    @State private var activeSheet: ActiveSheet?
    @State private var showingAlertFit = false
    @State private var showingAlertSelection = false
    @State var updateUserData: UserData?
    
    var body: some View {
        VStack {
            Button(action: {clothItemsFiltered = clothItemsRepo.clothItems.filter{$0.type == "Top"}; activeSheet = .top}, label: {
                if top != nil {
                    ClothItemView(clothItem: top!)
                }else {
                    Image(systemName: "square.tophalf.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 300)
                        .padding()
                }
            })
            Button(action: {clothItemsFiltered = clothItemsRepo.clothItems.filter{$0.type == "Bottom"}; activeSheet = .bottom}, label: {
                if bottom != nil {
                    ClothItemView(clothItem: bottom!)
                }else {
                    Image(systemName: "square.bottomhalf.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 300)
                        .padding()
                }
            })
            
            HStack {
                Button(action: {star = true; addFit(); star = false}, label: {
                    Image(systemName: "star")
                }).padding()
                Button(action: {addFit()}, label: {Text("Add")}).padding()
            }.padding()
            
            .alert(isPresented: $showingAlertFit) { Alert(title: Text("Wrong Selection"), message: Text("Fit already exists"), dismissButton: .default(Text("Got it!")))
            }
            .alert(isPresented: $showingAlertSelection) { Alert(title: Text("Wrong Selection"), message: Text("Items are incompatible or missing"), dismissButton: .default(Text("Got it!")))
            }
        }.padding()
        .sheet(item: $activeSheet) { item in
            switch item {
            case .top:
                NavigationView {
                    ClothItemsViewer(clothItems: $clothItemsFiltered, selectItem: $top)
                        .navigationBarItems(leading: Text("Top"), trailing: Button(action: {activeSheet = nil}, label: {
                            Text("Done")
                        }))
                }
            case .bottom:
                NavigationView {
                    ClothItemsViewer(clothItems: $clothItemsFiltered, selectItem: $bottom)
                        .navigationBarItems(leading: Text("Bottom"), trailing: Button(action: {activeSheet = nil}, label: {
                            Text("Done")
                        }))
                }
            }
        }
    }
    private func addFit() {
        if (bottom != nil && top != nil && bottom!.type == "Bottom" && top!.type == "Top") {
            let newClothFit = ClothFit(items: [top!.id!, bottom!.id!], star: star)
            if !clothFitsRepo.clothFits.contains(newClothFit) {
                clothFitsRepo.addClothFit(newClothFit)
                if !userDataRepo.userData!.triedClothFits.contains([newClothFit.items[0], newClothFit.items[1]]) {
                    updateUserData = userDataRepo.userData
                    updateUserData!.triedClothFits.append([newClothFit.items[0], newClothFit.items[1]])
                    userDataRepo.updateUserData(updateUserData!)
                }
            }else {
                showingAlertFit = true
            }
        }else {
            showingAlertSelection = true
        }
    }
}

struct AddClothFitView_Previews: PreviewProvider {
    static var previews: some View {
        AddClothFitView(clothItemsRepo: .constant(Resolver.resolve()), clothFitsRepo: .constant(Resolver.resolve()), userDataRepo: .constant(Resolver.resolve()))
    }
}
