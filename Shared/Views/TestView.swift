//
//  TestView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/25/21.
//

import SwiftUI

struct TestView: View {
    let pants = UIImage(named: "pants")
    let pointArray = [
        CGPoint(x: 0, y: 0),   //Start point
        CGPoint(x: 100, y: 0),
        CGPoint(x: 100, y: 100),
        CGPoint(x: 0, y: 100)  //End point
        ]
    var body: some View {
        VStack {
            Image("pants")
                .resizable()
                .scaledToFit()
            Image(uiImage: pants ?? UIImage(systemName: "circle")!)
                .resizable()
                .scaledToFit()
            let croppedImage = ZImageCropper.cropImage(ofImageView: UIImageView(image: pants), withinPoints: pointArray)
            Image(uiImage: (croppedImage ?? UIImage(systemName: "circle")! ))
                .resizable()
                .scaledToFit()
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
