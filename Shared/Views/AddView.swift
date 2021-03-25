//
//  AddView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/16/21.
//

import SwiftUI
import Vision

enum ActiveSheet: Identifiable {
    case first, second
    
    var id: Int {
        hashValue
    }
}

struct AddView: View {
    @Binding var clothItems: [ClothItem]
    @State private var newclothItemData = ClothItem.Datas()
    
    @State var activeSheet: ActiveSheet?
    
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    
    @State var points : String = ""
    var body: some View {
        VStack {
            if selectedImage != nil {
                                Image(uiImage: selectedImage!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 300, height: 300)
                            } else {
                                Image(systemName: "camera")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 300, height: 300)
                            }
                            
                            Button("Camera") {
                                activeSheet = .first
                                self.sourceType = .camera
                                self.isImagePickerDisplay.toggle()
                            }.padding()
                            
                            Button("Photo") {
                                activeSheet = .first
                                self.sourceType = .photoLibrary
                                self.isImagePickerDisplay.toggle()
                            }.padding()
            Button("Detect Contours", action: {
                            detectVisionContours()
            }).padding()
            Button(action: { activeSheet = .second }) {
                Image(systemName: "plus")
            }
            .sheet(item: $activeSheet) { item in
                        switch item {
                        case .first:
                            ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
                        case .second:
                            NavigationView {
                                ClothItemEditView(clothItemData: $newclothItemData)
                                    .navigationBarItems(leading: Button("Dismiss") {
                                        activeSheet = nil
                                    }, trailing: Button("Add") {
                                        let newclothItem = ClothItem(type: newclothItemData.type.id, color: newclothItemData.color, brand: newclothItemData.brand, price: newclothItemData.price, image: selectedImage)
                                            clothItems.append(newclothItem)
                                        activeSheet = nil
                                        })
                            }
                        }
                    }
        }
    }
    func detectVisionContours(){
        _ = CIContext()
                if let sourceImage = selectedImage
                {
                    let inputImage = CIImage.init(cgImage: sourceImage.cgImage!)
                    
                    let contourRequest = VNDetectContoursRequest.init()
                    contourRequest.revision = VNDetectContourRequestRevision1
                    contourRequest.contrastAdjustment = 1.0
//                    contourRequest.maximumImageDimension = 512


                    let requestHandler = VNImageRequestHandler.init(ciImage: inputImage, options: [:])

                    try! requestHandler.perform([contourRequest])
                    let contoursObservation = contourRequest.results?.first as! VNContoursObservation
                    
                    self.points  = String(contoursObservation.contourCount)
                    self.selectedImage = drawContours(contoursObservation: contoursObservation, sourceImage: sourceImage.cgImage!)

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
            renderingContext.addPath(contoursObservation.normalizedPath)
            renderingContext.strokePath()
            }
            
            return renderedImage
        }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(clothItems: .constant(ClothItem.data))
    }
}
