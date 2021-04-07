//
//  CropModeView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 4/3/21.
//

import SwiftUI

struct CropModeView: View {
    @Binding var selectedImage: UIImage?
    @Binding var clothItems: [ClothItem]
    var body: some View {
        VStack {
            NavigationLink(
                destination: ManualCropperView(image: $selectedImage, clothItems: $clothItems),
                label: {
                    Text("Manual Crop")
                        .frame(width: 300, height: 100)
                        .background(RoundedRectangle(cornerRadius: 4).stroke())
                        .foregroundColor(.green)
                })
                .padding()
            NavigationLink(
                destination: AutoCropperView(image: $selectedImage, clothItems: $clothItems),
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
        CropModeView(selectedImage: .constant(UIImage(named: "pants")), clothItems: .constant(ClothItem.data))
    }
}
