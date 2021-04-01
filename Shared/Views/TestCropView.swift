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
    @State var preProcessImage: UIImage?
    @State var contouredImage: UIImage?
    
    var body: some View {
        
        VStack{
            
            Text("Contours: \(points)")
            
            Image("pants")
                .resizable()
                .scaledToFit()
            
            if let image = preProcessImage{
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
            
            if let image = contouredImage{
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
            
            Button("Detect Contours", action: {
                detectVisionContours()
            })
        }
    }
    
    func detectVisionContours(){
        _ = CIContext()
        if let sourceImage = UIImage.init(named: "pants")
        {
            let inputImage = CIImage.init(cgImage: sourceImage.cgImage!)
            
            let contourRequest = VNDetectContoursRequest.init()
            contourRequest.revision = VNDetectContourRequestRevision1
            contourRequest.contrastAdjustment = 1.0
            contourRequest.maximumImageDimension = 512
            
            
            let requestHandler = VNImageRequestHandler.init(ciImage: inputImage, options: [:])
            
            try! requestHandler.perform([contourRequest])
            let contoursObservation = contourRequest.results?.first as! VNContoursObservation
            
            self.points  = String(contoursObservation.contourCount)
            self.contouredImage = drawContours(contoursObservation: contoursObservation, sourceImage: sourceImage.cgImage!)
            
        } else {
            self.points = "Could not load image"
        }
    }
    
    public func drawContours(contoursObservation: VNContoursObservation, sourceImage: CGImage) -> UIImage {
        let size = CGSize(width: sourceImage.width, height: sourceImage.height)
        let renderer = UIGraphicsImageRenderer(size: size)
        
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
            var childcontour: VNContour = contour.childContours[0]
            for c in contour.childContours {
                if c.pointCount > childlen {
                    childlen = c.pointCount
                    childcontour = c
                }
            }
                
            renderingContext.addPath(childcontour.normalizedPath)
            renderingContext.strokePath()
        }
        
        return renderedImage
    }
    
}

struct TestCropView_Previews: PreviewProvider {
    static var previews: some View {
        TestCropView()
    }
}
