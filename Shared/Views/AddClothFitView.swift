//
//  AddClothFitView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/29/21.
//

import SwiftUI

private enum ActiveSheet: Identifiable {
    case top, bottom
    
    var id: Int {
        hashValue
    }
}

struct AddClothFitView: View {
    @Binding var clothFits: [ClothFit]
    @Binding var clothItems: [ClothItem]
    @Binding var userData: UserData
    
    @State var clothItemsFiltered: [ClothItem]?
    
    @State var top: ClothItem?
    @State var bottom: ClothItem?
    @State var star: Bool = false
    
    @State private var activeSheet: ActiveSheet?
    
    @State private var showingAlertFit = false
    @State private var showingAlertSelection = false
    var body: some View {
        VStack {
            Button(action: {clothItemsFiltered = clothItems.filter{$0.type == "Top"}; activeSheet = .top}, label: {
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
            Button(action: {clothItemsFiltered = clothItems.filter{$0.type == "Bottom"}; activeSheet = .bottom}, label: {
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
            }
            
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
            let newClothFit = ClothFit(items: [top!.id, bottom!.id], star: star)
            if !clothFits.contains(newClothFit) {
                clothFits.append(newClothFit)
                if !userData.triedClothFits.contains(newClothFit) {
                    userData.triedClothFits.append(newClothFit)
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
        AddClothFitView(clothFits: .constant(ClothFit.data), clothItems: .constant(ClothItem.data), userData: .constant(UserData.data[0]))
    }
}
