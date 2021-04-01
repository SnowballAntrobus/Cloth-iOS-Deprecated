//
//  TestCropView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/31/21.
//

import SwiftUI
import Vision

struct TestCropView: View {
    
    @State var points : String = ""
    @State var contouredImage: UIImage?
    @State var path: [CGPoint]?
    @State var imageRatio: CGSize = .zero
    @State var imageSize: CGSize = .zero
    
    @State var image: UIImage? = UIImage(named: "pants")
    
    var body: some View {
        
        VStack{
            if (contouredImage != nil){
                VStack {
                    Image(uiImage: contouredImage ?? UIImage(systemName: "circle")!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                
            } else {
                Image(uiImage: image ?? UIImage(systemName: "circle")!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .background(rectReader())
            }
            
            Text("Num points: \(points)")
            Text("Size: \(imageSize.width) x \(imageSize.height)")
            Text("Ratio: \(imageRatio.width) x \(imageRatio.height)")
            
            
            
            Button("Detect Contours", action: {
                detectVisionContours()
            })
            Button("Crop", action: {
                crop()
            })
        }
    }
    
    private func rectReader() -> some View {
        return GeometryReader { (geometry) -> AnyView in
            let imageSize = geometry.size
            DispatchQueue.main.async {
                self.imageSize = imageSize
                self.imageRatio.height = image!.size.height / imageSize.height
                self.imageRatio.width = image!.size.width / imageSize.width
                self.imageSize = image!.size
            }
            return AnyView(Rectangle().fill(Color.clear))
        }
    }
    
    private func crop(){
        var pathF:[CGPoint] = []
        var i = 0
        for p in path! {
            if i % 10 == 0 {
                pathF.append(p)
                print(p)
            }
            i += 1
        }
        self.points  = String(pathF.count)
        self.contouredImage = ZImageCropper.cropImage(ofImageView: UIImageView(image: contouredImage), withinPoints: pathF)
    }
    
    private func detectVisionContours(){
        _ = CIContext()
        if let sourceImage = image
        {
            let inputImage = CIImage.init(cgImage: sourceImage.cgImage!)
            
            let contourRequest = VNDetectContoursRequest.init()
            contourRequest.revision = VNDetectContourRequestRevision1
            contourRequest.contrastAdjustment = 1.0
            contourRequest.maximumImageDimension = Int(image!.size.height)
            
            
            let requestHandler = VNImageRequestHandler.init(ciImage: inputImage, options: [:])
            
            try! requestHandler.perform([contourRequest])
            let contoursObservation = contourRequest.results?.first as! VNContoursObservation
            
            let contour = drawContours(contoursObservation: contoursObservation, sourceImage: sourceImage.cgImage!)
            self.contouredImage = contour.0
            
            var p: [CGPoint] = []
            for c in contour.1 {
                p.append(CGPoint(x: CGFloat(c[0])*imageSize.width, y: imageSize.height - CGFloat(c[1])*imageSize.height))
            }
            
            self.path = p
            
            self.points  = String(contour.1.count)
        } else {
            self.points = "Could not load image"
        }
    }
    
    public func drawContours(contoursObservation: VNContoursObservation, sourceImage: CGImage) -> (UIImage, [simd_float2]) {
        let size = CGSize(width: sourceImage.width, height: sourceImage.height)
        let renderer = UIGraphicsImageRenderer(size: size)
        var childcontour: VNContour? = nil
        let renderedImage = renderer.image { (context) in
            let renderingContext = context.cgContext
            
            let flipVertical = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: size.height)
            renderingContext.concatenate(flipVertical)
            
            renderingContext.draw(sourceImage, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            
            renderingContext.scaleBy(x: size.width, y: size.height)
            renderingContext.setLineWidth(5.0 / CGFloat(size.width))
            let redUIColor = UIColor.red
            renderingContext.setStrokeColor(redUIColor.cgColor)
            
            var contourlen: Int = contoursObservation.topLevelContours[0].pointCount
            var contour: VNContour = contoursObservation.topLevelContours[0]
            for c in contoursObservation.topLevelContours {
                if c.pointCount > contourlen {
                    contourlen = c.pointCount
                    contour = c
                }
            }
            var childlen: Int = contour.childContours[0].pointCount
            childcontour = contour.childContours[0]
            for c in contour.childContours {
                if c.pointCount > childlen {
                    childlen = c.pointCount
                    childcontour = c
                }
            }
            
            renderingContext.addPath(childcontour!.normalizedPath)
            renderingContext.strokePath()
        }
        
        return (renderedImage, childcontour!.normalizedPoints)
    }
    
}

struct TestCropView_Previews: PreviewProvider {
    static var previews: some View {
        TestCropView()
    }
}
