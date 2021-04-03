//
//  AddView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/16/21.
//

import SwiftUI
import Vision

private enum ActiveSheet: Identifiable {
    case picker, adder
    
    var id: Int {
        hashValue
    }
}

struct AddClothItemImageView: View {
    @Binding var clothItems: [ClothItem]
    
    @State private var activeSheet: ActiveSheet?
    
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
            }
            else {
                Image(systemName: "camera")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
            }
            
            Button("Camera") {
                activeSheet = .picker
                self.sourceType = .camera
                self.isImagePickerDisplay.toggle()
            }.padding()
            
            Button("Photo") {
                activeSheet = .picker
                self.sourceType = .photoLibrary
                self.isImagePickerDisplay.toggle()
            }.padding()
            
            .navigationBarItems(leading: Button("Add") {
                                    if selectedImage != nil {
                                        activeSheet = .adder
                                    }})
            
            .sheet(item: $activeSheet) { item in
                switch item {
                case .picker:
                    ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
                case .adder:
                    VStack {
                        NavigationLink(
                            destination: ManualCropperView(image: $selectedImage, clothItems: $clothItems),
                            label: {
                                Text("Manual Crop")
                            })
                        NavigationLink(
                            destination: Text("Destination"),
                            label: {
                                Text("Auto Crop")
                            })
                    }
                }
            }
        }
    }
}

struct AddClothItemImageView_Previews: PreviewProvider {
    static var previews: some View {
        AddClothItemImageView(clothItems: .constant(ClothItem.data))
    }
}
