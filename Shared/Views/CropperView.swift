//
//  CropperView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/25/21.
//

import SwiftUI

struct CropperView: UIViewRepresentable {
    @Binding var croppedImage: UIImage?

    func makeUIView(context: Context) -> ZImageCropperView {
        ZImageCropperView()
    }
    
    func updateUIView(_ uiView: ZImageCropperView, context: Context) {
        uiView.croppedImage = croppedImage
    }
    
}

struct CropperView_Previews: PreviewProvider {
    static var previews: some View {
        CropperView(croppedImage: .constant(UIImage(systemName: "UserImage")))
    }
}
