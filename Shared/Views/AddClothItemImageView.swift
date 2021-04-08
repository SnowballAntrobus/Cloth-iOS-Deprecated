//
//  AddView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/16/21.
//

import SwiftUI
import Vision
import Resolver

struct AddClothItemImageView: View {
    @Binding var clothItemsRepo: ClothItemRepository
    
    @State private var activeSheet = false
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
                activeSheet = true
                self.sourceType = .camera
                self.isImagePickerDisplay.toggle()
            }.padding()
            
            Button("Photo") {
                activeSheet = true
                self.sourceType = .photoLibrary
                self.isImagePickerDisplay.toggle()
            }.padding()
            
            .sheet(isPresented: $activeSheet) {
                ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
            }
            
            if selectedImage != nil {
                NavigationLink(
                    destination: CropModeView(clothItemsRepo: $clothItemsRepo, selectedImage: $selectedImage),
                    label: {
                        Text("Add")
                    }).padding()
            }
            
        }
    }
}


struct AddClothItemImageView_Previews: PreviewProvider {
    static var previews: some View {
        AddClothItemImageView(clothItemsRepo: .constant(Resolver.resolve()))
    }
}
