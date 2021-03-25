//
//  AddView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/16/21.
//

import SwiftUI
import Vision

enum ActiveSheet: Identifiable {
    case first, second
    
    var id: Int {
        hashValue
    }
}

struct AddView: View {
    @Binding var clothItems: [ClothItem]
    @State private var newclothItemData = ClothItem.Datas()
    
    @State var activeSheet: ActiveSheet?
    
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    
    var body: some View {
        VStack {
            if selectedImage != nil {
                                Image(uiImage: selectedImage!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 300, height: 300)
                            } else {
                                Image(systemName: "camera")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 300, height: 300)
                            }
                            
                            Button("Camera") {
                                activeSheet = .first
                                self.sourceType = .camera
                                self.isImagePickerDisplay.toggle()
                            }.padding()
                            
                            Button("Photo") {
                                activeSheet = .first
                                self.sourceType = .photoLibrary
                                self.isImagePickerDisplay.toggle()
                            }.padding()
            Button(action: { activeSheet = .second }) {
                Image(systemName: "plus")
            }
            .sheet(item: $activeSheet) { item in
                        switch item {
                        case .first:
                            ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
                        case .second:
                            NavigationView {
                                ClothItemEditView(clothItemData: $newclothItemData)
                                    .navigationBarItems(leading: Button("Dismiss") {
                                        activeSheet = nil
                                    }, trailing: Button("Add") {
                                        let newclothItem = ClothItem(type: newclothItemData.type.id, color: newclothItemData.color, brand: newclothItemData.brand, price: newclothItemData.price, image: selectedImage)
                                            clothItems.append(newclothItem)
                                        activeSheet = nil
                                        })
                            }
                        }
                    }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(clothItems: .constant(ClothItem.data))
    }
}
