//
//  CropperView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/25/21.
//

import SwiftUI

struct CropperView: View {
    @State var imageSize: CGSize = .zero
    
    let pants = UIImage(named: "pants")
    @State var points: [CGPoint] = []
    @State var pointsRezised: [CGPoint] = []
    
    @State var croppedImage: UIImage?
    var body: some View {
            if (croppedImage != nil){
                Image(uiImage: croppedImage ?? UIImage(systemName: "circle")!)
                    .resizable()
                    .scaledToFit()
            } else {
                VStack{
                    Image(uiImage: pants!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .background(rectReader())
                        .gesture(DragGesture().onChanged( { value in self.addNewPoint(value)}))
                        .overlay(DrawShape(points: points)
                            .stroke(lineWidth: 5)
                            .foregroundColor(.green))
                    Button(action: {cropImage()}, label: { Text("Crop") })
                }
            }
    }
    
    private func rectReader() -> some View {
        return GeometryReader { (geometry) -> AnyView in
            let imageSize = geometry.size
            DispatchQueue.main.async {
                self.imageSize = imageSize
                self.imageSize.height = pants!.size.height / imageSize.height
                self.imageSize.width = pants!.size.width / imageSize.width
            }
            return AnyView(Rectangle().fill(Color.clear))
        }
    }

    private func addNewPoint(_ value: DragGesture.Value) {
        var x: CGFloat = value.location.x
        var y: CGFloat = value.location.y
        
        x = x * imageSize.width
        y = y * imageSize.height
        
        pointsRezised.append(CGPoint(x: x, y: y))
        points.append(value.location)
    }
    
    private func cropImage() {
        croppedImage = ZImageCropper.cropImage(ofImageView: UIImageView(image: pants), withinPoints: pointsRezised)
    }
}

struct CropperView_Previews: PreviewProvider {
    static var previews: some View {
        CropperView()
    }
}

struct DrawShape: Shape {

    var points: [CGPoint]

    // drawing is happening here
    func path(in rect: CGRect) -> Path {
        var path = Path()
        guard let firstPoint = points.first else { return path }

        path.move(to: firstPoint)
        for pointIndex in 1..<points.count {
            path.addLine(to: points[pointIndex])

        }
        return path
    }
}
