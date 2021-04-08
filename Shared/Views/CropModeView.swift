//
//  CropModeView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 4/3/21.
//

import SwiftUI
import Resolver

struct CropModeView: View {
    @Binding var clothItemsRepo: ClothItemRepository
    @Binding var selectedImage: UIImage?
    
    var body: some View {
        VStack {
            NavigationLink(
                destination: ManualCropperView(clothItemsRepo: $clothItemsRepo, image: $selectedImage),
                label: {
                    Text("Manual Crop")
                        .frame(width: 300, height: 100)
                        .background(RoundedRectangle(cornerRadius: 4).stroke())
                        .foregroundColor(.green)
                })
                .padding()
            NavigationLink(
                destination: AutoCropperView(clothItemsRepo: $clothItemsRepo, image: $selectedImage),
                label: {
                    Text("Auto Crop")
                        .frame(width: 300, height: 100)
                        .background(RoundedRectangle(cornerRadius: 4).stroke())
                        .foregroundColor(.green)
                })
                .padding()
        }
    }
}

struct CropModeView_Previews: PreviewProvider {
    static var previews: some View {
        CropModeView(clothItemsRepo: .constant(Resolver.resolve()), selectedImage: .constant(UIImage(named: "pants")))
    }
}
