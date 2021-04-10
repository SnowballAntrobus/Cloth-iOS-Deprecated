//
//  testView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 4/9/21.
//

import SwiftUI
import FirebaseStorage
import FirebaseStorageUI
import SDWebImageSwiftUI

struct testView: View {
    var body: some View {
        VStack {
            WebImage(url: (NSURL.sd_URL(with: Storage.storage().reference().child("images/48E92936-1EE0-4F60-9D73-9CC1BDAC4B67.jpg"))! as URL))
        }.onAppear() {
            SDImageLoadersManager.shared.loaders = [FirebaseStorageUI.StorageImageLoader.shared]
            SDWebImageManager.defaultImageLoader = SDImageLoadersManager.shared
        }
    }
}
  

struct testView_Previews: PreviewProvider {
    static var previews: some View {
        testView()
    }
}
