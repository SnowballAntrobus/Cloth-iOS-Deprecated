//
//  CropperView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/25/21.
//

import SwiftUI
import AVFoundation

struct CropperView: View {
    @State var frame: CGSize = .zero
    
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
                    GeometryReader { (geometry) in
                                    self.makeView(geometry)
                                }
                    Button(action: {cropImage()}, label: { Text("Crop") })
                }
            }
    }
    
    private func makeView(_ geometry: GeometryProxy) -> some View {
        print(geometry.size.width, geometry.size.height)
            DispatchQueue.main.async {
                self.frame = geometry.size
                self.frame.height = pants!.size.height / frame.height
                self.frame.width = pants!.size.width / frame.width
            }

            return Image(uiImage: pants!)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .gesture(DragGesture().onChanged( { value in self.addNewPoint(value)}))
                                .overlay(DrawShape(points: points)
                                            .stroke(lineWidth: 5)
                                            .foregroundColor(.green))
        }

    private func addNewPoint(_ value: DragGesture.Value) {
        var x = value.location.x
        var y = value.location.y
        
        x = x * frame.height
        y = y * frame.height
        
        pointsRezised.append(CGPoint(x: x, y: y))
        points.append(value.location)
    }
    
    private func cropImage() {
        print(points)
        print(pointsRezised)
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
