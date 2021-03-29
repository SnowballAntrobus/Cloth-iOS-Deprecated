//
//  AddView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/16/21.
//

import SwiftUI
import Vision

struct AddClothItemImageView: View {
    @Binding var clothItems: [ClothItem]
    
    @State var activeSheet = false
    
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    
    var body: some View {
        NavigationView{
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
                
                NavigationLink(
                    destination: CropperView(image: $selectedImage, clothItems: $clothItems),
                    label: {
                        Image(systemName: "plus")
                    }).padding()
                
                .sheet(isPresented: $activeSheet) {
                    ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
                }
            }.navigationBarHidden(true)
        }
    }
}

struct AddClothItemImageView_Previews: PreviewProvider {
    static var previews: some View {
        AddClothItemImageView(clothItems: .constant(ClothItem.data))
    }
}
